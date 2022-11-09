import re
from typing import Optional

from django.http.request import QueryDict
from django.shortcuts import reverse
from sympy.logic.inference import satisfiable

import moduleapp
from ringapp.forms import term_to_readable
from ringapp.models import Property, Logic, Dimension
from ringapp.LogicUtils import LogicEngine
from ringapp.SearchUtils import ring_search, mirror_search_terms, module_search

from ringapp.constants import sidetype_choices

sidetype_dict = dict(sidetype_choices)


def suggest_new_example(logic, assume_commutative=False):
    if logic.variety == 1:
        print("suggest_new_example does not work with equivalences.")
        return

    log_eng = LogicEngine()
    expr = ~log_eng.parse_logic(logic, convert_to_converse=True)

    if assume_commutative:
        expr = expr.subs('x_1', True)  # We want to remove commutativity from consideration
    modls = satisfiable(expr, all_models=True)
    results = []
    for modl in modls:
        has = [k.name for k, v in modl.items() if v is True]
        lacks = [k.name for k, v in modl.items() if v is False]
        has = map(lambda x: x.replace('x', 'H'), has)
        lacks = map(lambda x: x.replace('x', 'L'), lacks)
        terms = list(map(lambda x: x.replace('_', ''), has))
        terms.extend(map(lambda x: x.replace('_', ''), lacks))
        narrow, _ = ring_search(terms)
        if len(narrow) > 0:
            continue
        terms = mirror_search_terms(terms)
        narrow, _ = ring_search(terms)
        if len(narrow) > 0:
            continue

        has = [item[1:] for item in terms if item.startswith('H')]
        lacks = [item[1:] for item in terms if item.startswith('L')]
        has_readable = [term_to_readable(x) for x in has]
        lacks_readable = [term_to_readable(x) for x in lacks]

        qd = QueryDict(mutable=True)
        qd.setlist('H', has)
        qd.setlist('L', lacks)
        results.append((has_readable, lacks_readable, '{}?{}'.format(reverse('results'), qd.urlencode())))

    return results


def suggest_asymm_examples():
    asymm = Property.objects.filter(symmetric=False)
    results = []
    for prop in asymm:
        terms = ['H{}r'.format(prop.id), 'L{}l'.format(prop.id)]
        narrow, _ = ring_search(terms)
        if len(narrow) > 0:
            continue
        terms = mirror_search_terms(terms)
        narrow, _ = ring_search(terms)
        if len(narrow) > 0:
            continue

        qd = QueryDict(mutable=True)
        qd.appendlist('H', '{}l'.format(prop.id))
        qd.appendlist('L', '{}r'.format(prop.id))

        results.append((prop, '{}?{}'.format(reverse('results'), qd.urlencode())))

    return results


def negate_souffle(phrase):
    pat = re.compile('([_a-z]+)\("([a-z]+)"')
    match = re.search(pat, phrase)
    swap = {"has": "lacks",
            "lacks": "has"}
    if match:
        return re.sub(pat, lambda x: f'{x.group(1)}("{swap[x.group(2)]}"', phrase)
    return


class NegationError(Exception):
    pass


class ParseError(Exception):
    pass


def souffle_to_ring_terms(mat):
    mode, side, pk = mat.group(1), int(mat.group(2)), mat.group(3)
    mode = 'H' if mode == "has" else 'L'
    if side == 0:
        return [mode + pk, ]
    elif side == 1:
        if mode == 'H':
            return [mode + pk + 'l', mode + pk + 'r']
        else:
            raise ParseError(f"Negation would entail a disjunction in search: not supported.")
    elif side == 2:
        return [mode + pk + 'l']
    elif side == 3:
        return [mode + pk + 'r']
    elif side == 4:
        if mode == 'L':
            return [mode + pk + 'l', mode + pk + 'r']
        else:
            raise ParseError(f"Negation would entail a disjunction in search: not supported.")


def souffle_to_module_terms(mat):
    mode, pk = mat.group(1), mat.group(2)
    mode = 'H' if mode == "has" else 'L'
    return [mode + pk, ]


def souffle_to_terms(phrase):
    pat = re.compile('ring_deduced\("([a-z]+)",([0-4]),([0-9]+)')
    mat = pat.search(phrase)
    if mat:
        return souffle_to_ring_terms(mat)
    mod_pat = re.compile('module_deduced\("([a-z]+)",([0-9]+)')
    mat = mod_pat.search(phrase)
    if mat:
        return souffle_to_module_terms(mat)

    if not mat:
        raise ParseError("Had trouble converting souffle to terms")



def humanize_souffle_list(phraseliststr: str) -> str:
    phraselist = phraseliststr.split(' AND ')
    humanized = filter(None, map(humanize_souffle, phraselist))
    return ' AND '.join(humanized)


def humanize_souffle(phrase: str) -> Optional[str]:
    pat = re.compile('ring_deduced\(("has"|"lacks"|X),([0-4]),([0-9]+)')
    mat = pat.search(phrase)

    if mat:
        mode, side, pk = mat.groups()
        side = int(side)
        return humanize_ring_souffle(mode, side, pk)

    pat = re.compile('module_deduced\(("has"|"lacks"|X),([0-9]+)')
    mat = pat.search(phrase)
    if mat:
        mode, pk = mat.groups()
        return humanize_module_souffle(mode, pk)

    pat = re.compile('ring_dim_deduced\("([_\\\{\}a-zA-Z0-9\$]+)",([0-9]),([0-9]+)')
    mat = pat.search(phrase)
    if mat:
        value, side, pk = mat.groups()
        return humanize_ring_dim_souffle(value, side, pk)

    if phrase == '':
        return None

    raise ParseError(f"This phrase was not parseable: {phrase}")


def humanize_ring_souffle(mode, side, pk):
    prop: Property = Property.objects.get(pk=pk)
    if mode.strip('"') == "has":
        modestr = 'is'
    elif mode.strip('"') == "lacks":
        modestr = 'is not'
    else:
        modestr = mode

    side = sidetype_dict[side]
    if side == '':
        return f'ring {modestr} {prop.name}'
    else:
        return f'ring {modestr} {prop.name} on the {side}'


def humanize_ring_dim_souffle(value, side, pk):
    dim = Dimension.objects.get(pk=pk)
    if side == '2':
        return f'has {dim.name} {value} on the left'
    elif side == '3':
        return f'has {dim.name} {value} on the right'
    elif side == '0':
        return f'has {dim.name} {value}'
    else:
        raise ValueError()


def humanize_module_souffle(mode, pk):
    prop = moduleapp.models.Property.objects.get(pk=pk)
    if mode.strip('"') == "has":
        modestr = 'is'
    elif mode.strip('"') == "lacks":
        modestr = 'is not'
    else:
        modestr = mode
    return f'module {modestr} {prop.name}'


def simple_irreversible_ring_logics():
    logics = Logic.objects.filter(variety=0)\
        .exclude(hyps__contains=' AND ')\
        .exclude(concs__contains=' AND ')
    results = []
    for logic in logics:
        try:
            conc, hyp = logic.hyps, logic.concs  # forming the inverse
            try:
                conc = negate_souffle(conc)  # needed to find a counterexample
            except NegationError:
                continue

            searchterms = souffle_to_terms(hyp)
            searchterms.extend(souffle_to_terms(conc))
            search_result, _ = ring_search(searchterms)

            if len(search_result) > 0:
                continue

            qd = QueryDict(mutable=True)
            qd.setlist('H', [t[1:] for t in searchterms if t.startswith('H')])
            qd.setlist('L', [t[1:] for t in searchterms if t.startswith('L')])
            suggestion = f"{humanize_souffle(hyp)} and {humanize_souffle(conc)}"
            url = '{}?{}'.format(reverse('results'), qd.urlencode())
            results.append((suggestion, url))
        except ParseError as exc:
            print(f"{logic} did not parse: {exc!r}")
    return results


def simple_irreversible_module_logics():
    logics = moduleapp.models.Logic.objects.filter(variety=0)\
        .exclude(hyps__contains=' AND ')\
        .exclude(concs__contains=' AND ')\
        .exclude(hyps__contains='ring_deduced')
    results = []
    for logic in logics:
        try:
            conc, hyp = logic.hyps, logic.concs  # forming the inverse
            try:
                conc = negate_souffle(conc)  # needed to find a counterexample
            except NegationError:
                continue

            searchterms = souffle_to_terms(hyp)
            searchterms.extend(souffle_to_terms(conc))
            search_result, _ = module_search(searchterms)

            if len(search_result) > 0:
                continue

            qd = QueryDict(mutable=True)
            qd.setlist('H', [t[1:] for t in searchterms if t.startswith('H')])
            qd.setlist('L', [t[1:] for t in searchterms if t.startswith('L')])
            suggestion = f"{humanize_souffle(hyp)} and {humanize_souffle(conc)}"
            url = '{}?{}'.format(reverse('module-results'), qd.urlencode())
            results.append((suggestion, url))
        except ParseError as exc:
            print(f"{logic} did not parse: {exc!r}")
    return results

