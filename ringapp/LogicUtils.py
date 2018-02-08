from copy import deepcopy
from time import time
import logging
from django.core.cache import cache
from django.db import transaction
from sympy import symbols, And, Or, Implies, Equivalent
from sympy.logic.boolalg import BooleanTrue
from sympy.logic.inference import satisfiable
from ringapp import models


log = logging.getLogger(__name__)


class LogicError(Exception):
    """
    Something has gone wrong during Logic evaluation
    """
    pass


class InvalidSymbolError(Exception):
    """
    Somehow a variable was named outside of the scheme x_[0-9]+(_(l|r))?
    """
    pass


class LogicEngine(object):
    __instance = None

    def __new__(cls):
        """
        A big singleton object whose function is to do the deduction process
        on all rings in storage using all logic in storage
        """
        if LogicEngine.__instance is None:
            log.info('Bootstrapping LogicEngine for the first time')
            t0 = time()
            LogicEngine.__instance = object.__new__(cls)
            LogicEngine.__instance.term_to_symbol = {}
            LogicEngine.__instance.symbol_to_prop = {}
            LogicEngine.__instance.logic_to_expr = {}

            LogicEngine.__instance.init_maps()
            LogicEngine.__instance.init_cache()
            LogicEngine.__instance.load_logic()

            # Too slow in practice! Worker times out...
            # LogicEngine.__instance.load_ringproperties()
            t1 = time()
            log.info('LogicEngine constructed after {}s'.format(t1-t0))

        return LogicEngine.__instance

    def reinitialize(self):
        self.init_maps()
        self.init_cache()
        self.load_logic()

    def init_maps(self):
        """
        Populate term_to_symbol and symbol_to_prop maps
        """
        log.debug('LogicEngine.init_maps')
        # Make boolean symbols for all existing properties
        for prop in models.Property.objects.all():
            symb = 'x_{}'.format(prop.id)
            if prop.symmetric:
                self.term_to_symbol['{}'.format(prop.id)] = \
                    symbols(symb)
                self.symbol_to_prop[symb] = prop
            else:
                symb_l = symb + '_l'
                symb_r = symb + '_r'
                self.term_to_symbol['{}l'.format(prop.id)] = \
                    symbols(symb_l)
                self.term_to_symbol['{}r'.format(prop.id)] = \
                    symbols(symb_r)
                self.symbol_to_prop[symb_l] = prop
                self.symbol_to_prop[symb_r] = prop

    def init_cache(self):
        """
        Create a dict of dicts, keyed first by Ring, then by logical symbol.
        The value of each is initialized to the logical symbol, then replaced with
        True or False depending on what is known.
        """
        log.debug('LogicEngine.init_cache')
        props_dict = {}
        empty_set = set()
        for prop in models.Property.objects.all():
            key = str(prop.id)
            if prop.symmetric:
                props_dict[self.term_to_symbol[key]] = \
                    self.term_to_symbol[key]
            else:
                props_dict[self.term_to_symbol[key + 'l']] = \
                    self.term_to_symbol[key + 'l']
                props_dict[self.term_to_symbol[key + 'r']] = \
                    self.term_to_symbol[key + 'r']
        for ring in models.Ring.objects.all():
            cache.set('ring_props:{}'.format(ring.id), deepcopy(props_dict))
            cache.set('ring_applied:{}'.format(ring.id), empty_set.copy())

    def load_ringproperties(self, ring=None):
        """
        Iterate through RingProperty objects and store the states
        in memory. These will be used to substitute into logical expressions.
        :param ring: If not None, only load the ringproperties for this ring.
        """
        log.debug('LogicEngine.load_ringproperties')
        rp_supply = models.RingProperty.objects.select_related('ring', 'property')
        if ring is not None:
            rp_supply = rp_supply.filter(ring=ring)
            local_cache = {ring: cache.get('ring_props:{}'.format(ring.id))}
        else:
            local_cache = {r: cache.get('ring_props:{}'.format(r.id)) for r in
                           models.Ring.objects.all()}

        for rp in rp_supply:
            key = str(rp.property.id)
            local_ring_cache = local_cache[rp.ring]
            if local_ring_cache is None:
                log_eng = LogicEngine()
                local_ring_cache = local_cache[rp.ring]
            if rp.property.symmetric:
                if rp.has_on_left is True or rp.has_on_right is True:
                    local_ring_cache[self.term_to_symbol[key]] = True
                elif rp.has_on_left is False or rp.has_on_right is False:
                    local_ring_cache[self.term_to_symbol[key]] = False
            else:
                if rp.has_on_left is True:
                    local_ring_cache[self.term_to_symbol[key + 'l']] = True
                elif rp.has_on_left is False:
                    local_ring_cache[self.term_to_symbol[key + 'l']] = False
                if rp.has_on_right is True:
                    local_ring_cache[self.term_to_symbol[key + 'r']] = True
                elif rp.has_on_right is False:
                    local_ring_cache[self.term_to_symbol[key + 'r']] = False

        # Store the changes back in cache
        for k, v in local_cache.items():
            cache.set('ring_props:{}'.format(k.id), v)

    def parse_logic(self, logic, switch_sides=False, convert_to_converse=False):
        """
        Read the logic model and formulate the symbolic expression
        :param logic A Logic model instance
        :param switch_sides: if True, reverse the sides indicated by the
                             logic model's side field
        :param convert_to_converse: if True, swap hyps and concs
        :return: symbolic expression
        """

        # FIXME: dumb hard coding
        side_swap = {
            0: 0,
            1: 1,
            2: 3,
            3: 2,
            4: 4
        }
        hyps = logic.hyps.all()
        concs = logic.concs.all()
        if convert_to_converse:
            hyps, concs = concs, hyps

        hyp_expr = []
        conc_expr = []
        # form expression for hypothesis
        for pside in hyps:
            if switch_sides is True:
                pside.side = side_swap[pside.side]
            hyp_expr.append(self.parse_pside(pside))

        # form expression for conclusion
        for pside in concs:
            if switch_sides is True:
                pside.side = side_swap[pside.side]
            conc_expr.append(self.parse_pside(pside))

        hyp_expr = And(*hyp_expr)
        conc_expr = And(*conc_expr)

        # FIXME: dumb hard coding
        # is it an implication or an equivalence?
        if logic.variety == 0:
            return Implies(hyp_expr, conc_expr)
        elif logic.variety == 1:
            return Equivalent(hyp_expr, conc_expr)

    def parse_pside(self, pside):
        """
        Translate property-side combinations into a logical expression
        :param pside: a PropertySide object
        :return: A logical expression of the PropertySide object
        """
        base_key = str(pside.property.id)
        if pside.property.symmetric:
            return self.term_to_symbol[base_key]
        else:
            if pside.side == 1:
                return And(self.term_to_symbol[base_key+'l'], self.term_to_symbol[base_key+'r'])
            elif pside.side == 2:
                return self.term_to_symbol[base_key + 'l']
            elif pside.side == 3:
                return self.term_to_symbol[base_key + 'r']
            elif pside.side == 4:
                return Or(self.term_to_symbol[base_key+'l'], self.term_to_symbol[base_key+'r'])
            else:
                raise NotImplementedError

    def load_logic(self):
        """
        Cycle through stored logic and keep a collection of sympy expressions 
        for all of them. Currently does not manage addition of new logic after
        original creation of the singleton.
        """
        for logic in models.Logic.objects.all():
            expression = self.parse_logic(logic)
            if logic.symmetric:
                self.logic_to_expr[logic] = (expression, )
            else:
                expression2 = self.parse_logic(logic, switch_sides=True)
                self.logic_to_expr[logic] = (expression, expression2)

    @staticmethod
    def merge_if_possible(d1, d2):
        """
        Merge two dicts, but only if they agree on the keys they share.
        :param d1: dict
        :param d2: dict
        :return: Merged dict
        :exception LogicError: occurs if the two share a key with distinct values
        """
        overlap = d1.keys() & d2.keys()
        for key in overlap:
            if d1[key] == d2[key]:
                continue
            raise LogicError('Could not merge logical models: {} {}'.format(d1, d2))
        return {**d1, **d2}

    def apply_logic(self, logic, ring, tentative):
        """
        Evaluate if a Logic is satisfied by a Ring, or if there is a 
        unique model that satisfies it.
        :param logic: The Logic to apply
        :param ring: The Ring instance being evaluated
        :param tentative: A dict of tentative values beyond the cached ones
               which will be added if they do not cause any conflicts in the end.
        :return: (dict, bool) The dict of values of symbols for the unique models that
                 satisfies the expression, if it exists. If no new values are
                 needed, this dict may be empty. The bool indicates whether or not
                 all versions of the expression have been exhausted for this ring
        :exception LogicError, if the values are inconsistent with the Logic
                   This indicates an inconsistency in the values for the Ring, 
                   or else an inconsistency of the Logic entries
        """
        log.debug('Applying logic_id={} to ring_id={}'.format(logic.id, ring.id))
        exprs = self.logic_to_expr[logic]  # the symbolic expression of the logic
        known_props = cache.get('ring_props:{}'.format(ring.id))  # known values/symbols
        if known_props is None:
            self.load_ringproperties(ring)
            known_props = cache.get('ring_props:{}'.format(ring.id))

        ret_dict = {}
        all_done = 0
        for expr in exprs:
            result = expr.subs(known_props)
            result = result.subs(tentative)
            modls = list(satisfiable(result, all_models=True))
            if len(modls) > 1:
                continue  # more than one model: nothing to be deduced
            modl = modls[0]

            # if no models exist, we get False (python primitive False)
            if modl is False:
                raise LogicError('Logic error encountered while processing {} with {}:{}'
                                 .format(ring, logic.id, logic))

            # If no symbols remain, the model will look like {True, True} where the
            # second true is the python primitive, and the first True is a sympy True
            if len(modl) == 1:
                check, _ = list(modl.items())[0]
                if isinstance(check, BooleanTrue):
                    all_done += 1  # Nothing learned, but should note success
                    continue

            # at this point, it should be a dict full of symbol:boolean keyvalues,
            # the unique thing that satisfies the expression
            ret_dict = self.merge_if_possible(ret_dict, modl)
            all_done += 1  # notes that we found the only model that can work

        if all_done > 2:
            log.error('This should not happen. Logics only evaluate one or two expressions...')

        # right hand side will only be true if all expressions were satisfied
        return ret_dict, all_done == len(exprs)

    def process_ring(self, ring):
        """
        Apply all Logics to a Ring which are worth applying. Update their caches and
            RingProperty objects, if successful.
        :param ring: Ring object
        :return: The number of new values added
        """
        def attempt_to_set(obj, attr, value):
            """
            Attempt to set attr on obj as long as the value doesn't contradict 
                   any existing value
            :param obj: An object
            :param attr: A field on obj
            :param value: True, False
            :return: True or False, depending on if the property was set or not
            :exception LogicError: raised if proposed value contradicts a stored one
            """
            if getattr(obj, attr) is None:
                setattr(obj, attr, value)
                return True
            elif getattr(obj, attr) is not value:
                raise LogicError('Value conflicts with stored value.')
            else:
                return False

        log.info('Running Logic entries against ring_id={}'
                 .format(ring.id))

        # Need to pick up complete copy of current state.
        self.load_ringproperties(ring)
        applied_logic = cache.get('ring_applied:{}'.format(ring.id))
        if applied_logic is None:
            applied_logic = set()
        logics = models.Logic.objects.exclude(id__in=applied_logic)
        tentative = {}
        successfully_applied = set()
        new_findings = {}
        try:
            with transaction.atomic():
                for logic in logics:
                    new_findings, complete = self.apply_logic(logic, ring, tentative)
                    tentative = self.merge_if_possible(tentative, new_findings)
                    if complete:
                        successfully_applied.add(logic.id)
                    for symbol, value in new_findings.items():
                        data = str(symbol).split('_')
                        if len(data) == 2:
                            _, prop_id = data
                            rp, created = models.RingProperty.objects.get_or_create(
                                ring=ring,
                                property=models.Property.objects.get(id=prop_id)
                            )

                            changed = attempt_to_set(rp, 'has_on_left', value)
                            if changed:
                                rp.reason_left = 'Logic {}: {}'.format(logic.id, logic)[:200]

                            changed = attempt_to_set(rp, 'has_on_right', value)
                            if changed:
                                rp.reason_right = 'Logic {}: {}'.format(logic.id, logic)[:200]

                        elif len(data) == 3:
                            _, prop_id, side = data

                            rp, created = models.RingProperty.objects.get_or_create(
                                ring=ring,
                                property=models.Property.objects.get(id=prop_id))
                            if side == 'l':
                                changed = attempt_to_set(rp, 'has_on_left', value)
                                if changed:
                                    rp.reason_left = 'Logic {}: {}'.format(logic.id, logic)[:200]

                            elif side == 'r':
                                changed = attempt_to_set(rp, 'has_on_right', value)
                                if changed:
                                    rp.reason_right = 'Logic {}: {}'.format(logic.id, logic)[:200]

                            else:
                                raise InvalidSymbolError('Invalid variable name {}'.format(symbol))
                        else:
                            raise InvalidSymbolError('Invalid variable name: {}'.format(symbol))
                        rp.save()

            # first line after atomic transaction manager closed

        except (LogicError, InvalidSymbolError) as exc:
            log.error('process_ring failed for {}: {!r}'.format(ring, exc))
            raise
        # the new tentative values appear to check out!
        # Avoid re-applying these Logics again
        applied_logic.update(successfully_applied)
        cache.set('ring_applied:{}'.format(ring.id), applied_logic)
        log.info('Added {} more RingProperties and '
                 'eliminated {} Logics for {}'.format(len(tentative),
                                                      len(successfully_applied), ring))
        return len(new_findings)

    def add_ringproperty(self, rp):
        raise NotImplementedError

    def add_ring(self):
        raise NotImplementedError

    def add_property(self):
        raise NotImplementedError

    def add_logic(self):
        raise NotImplementedError

    def invalidate_ring(self):
        raise NotImplementedError

    def invalidate_property(self):
        raise NotImplementedError

    def invalidate_logic(self):
        raise NotImplementedError
