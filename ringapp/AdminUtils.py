from models import Ring, Property, RingProperty, Logic, Equivalents
from models import CommProperty, CommRingProperty, CommLogic, CommEquivalents
from models import test_RingProperty, test_Ring
from subprocess import call
from datetime import datetime
import time
import os
import pickle
from django.db.models.query import QuerySet
import logging
import logging.handlers
from collections import defaultdict

LOG_FILENAME = 'ringapp/logs/deduction.log'

dlogger = logging.getLogger('DeductionLogger')
dlogger.setLevel(logging.DEBUG)
handler = logging.handlers.RotatingFileHandler(LOG_FILENAME, maxBytes=50000, backupCount=5)
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
dlogger.addHandler(handler)


# ### FILE PROCESSING SCRIPTS ###
def timestamp():
    return datetime.fromtimestamp(time.time()).strftime(' % Y-%m-%d-%Hh%Mm%Ss')


def rewriteName(st):
    """Makes database property names with (left)/(right) a little more readable."""
    if st[-7:] == ' (left)':
        return 'left %s' % st[:-7]
    elif st[-8:] == ' (right)':
        return 'right %s' % st[:-8]
    else:
        return st


def view_logic(lid, comm=False):
    """Retrieve readable contents of a logic entry"""
    if comm is True:
        LogSupply = CommLogic
        PropSupply = CommProperty
    else:
        LogSupply = Logic
        PropSupply = Property
    L = LogSupply.objects.get(pk=lid)
    conds = [L.cond_1, L.cond_2, L.cond_3, L.cond_4]
    conds = filter(lambda x: x is not None, conds)
    conc = L.conc
    readable_conds = [PropSupply.objects.get(pk=i).name for i in conds]
    readable_conds = map(rewriteName, readable_conds)
    readable_conc = rewriteName(PropSupply.objects.get(pk=conc).name)
    output = " and ".join(readable_conds) + " ==> %s." % readable_conc
    return output


def generate_readable_logic(comm=False):
    if comm is True:
        LogSupply = CommLogic
        PropSupply = CommProperty
    else:
        LogSupply = Logic
        PropSupply = Property
    logics = LogSupply.objects.filter(readable__isnull=True)
    for L in logics:
        conds = [L.cond_1, L.cond_2, L.cond_3, L.cond_4]
        conds = filter(lambda x: x is not None, conds)
        conc = L.conc
        readable_conds = [PropSupply.objects.get(pk=i).name for i in conds]
        readable_conds = map(rewriteName, readable_conds)
        readable_conc = rewriteName(PropSupply.objects.get(pk=conc).name)
        output = " and ".join(readable_conds) + " implies %s" % readable_conc
        L.readable = output
        L.save()


# ### SEARCH SCRIPTS ###
def find_rings(scope, has=[], lacks=[], comm=False):
    """This is the main search method for the search page.
    """
    # results = Ring.objects.all()
    if scope == 'w':
        return wide_ring_search(has=has, lacks=lacks, comm=comm)
    elif scope == 'n':
        return narrow_ring_search(has=has, lacks=lacks, comm=comm)


def mirror_search(scope, has=[], lacks=[]):
    """This method performs the mirror image search for the search page.
    """
    mapping = mirror_map()
    mhas = [mapping.get(H, H) for H in has]
    mlacks = [mapping.get(L, L) for L in lacks]
    return find_rings(scope=scope, has=mhas, lacks=mlacks)


def mirror_map():
    """Creates an up-to-date map for left/right properties in the database
    """
    lefts = [ (x.property_id, x.name) for x in Property.objects.filter(name__contains='(left)')]
    half1 = [(x[0], Property.objects.get(name=x[1].replace('left', 'right')).property_id) for x in lefts]
    half2 = [(x[1], x[0]) for x in half1]
    mirror_mapping = dict(half1 + half2)
    return mirror_mapping


def mirror_map_2():
    """version of mirror map including symmetric conditions as fixed points"""
    remainder = [x.property_id for x in Property.objects.all() if x.property_id not in mirror_map().keys()]
    mirror_mapping = [(c, c) for c in remainder]
    old_mm = mirror_map()
    old_mm = old_mm.items()
    mirror_mapping += old_mm
    mirror_mapping += [(None, None)]
    return dict(mirror_mapping)
# mm = mirror_map_2()


def half_mirror_map():
    mapping = mirror_map().items()
    mapping = [x for x in mapping if x[0] < x[1]]
    mapping = dict(mapping)
    return mapping


def wide_ring_search(has=[], lacks=[], comm=False):
    """Returns a queryset of ring objects which do not fail the requirements
    """
    if comm is True:
        PropSupply = CommProperty
        RPSupply = CommRingProperty
    else:
        PropSupply = Property
        RPSupply = RingProperty
    supply = Ring.objects.all()
    # working with haslist
    for pid in has:
        supply = supply.exclude(ring_id__in=[x.ring.ring_id for x in RPSupply.objects.filter(property=PropSupply.objects.get(pk=pid), has_property=0)])
    # working with lackslist
    for pid in lacks:
        supply = supply.exclude(ring_id__in=[x.ring.ring_id for x in RPSupply.objects.filter(property=PropSupply.objects.get(pk=pid), has_property=1)])
    return supply


def narrow_ring_search(has=[], lacks=[], comm=False, test=False):
    """Returns a queryset of ring objects that are known satisfy all the requirements
    """
    if test is True:
        PropSupply = Property
        RPSupply = test_RingProperty
        supply = test_Ring.objects.all()
    elif comm is True:
        PropSupply = CommProperty
        RPSupply = CommRingProperty
        supply = Ring.objects.all()
    else:
        PropSupply = Property
        RPSupply = RingProperty
        supply = Ring.objects.all()
    # working with haslist
    for pid in has:
        supply = supply.filter(ring_id__in=[x.ring.ring_id for x in RPSupply.objects.filter(property=PropSupply.objects.get(pk=pid), has_property=1)])
    # working with lackslist
    for pid in lacks:
        supply = supply.filter(ring_id__in=[x.ring.ring_id for x in RPSupply.objects.filter(property=PropSupply.objects.get(pk=pid), has_property=0)])
    return supply

# ###  DATABASE PROCESSING SCRIPTS ###


def symmetrize():
    """SymmScript
    Make left-right conditions symmetric for commutative rings
    """
    print 'Starting SymmScript...'
    # query ringproperty table for rings that are commutative
    rps = RingProperty.objects.filter(property=Property.objects.get(pk=1), has_property=1)
    comm_rings = [x.ring for x in rps]
    comm_rings = list(set(comm_rings))

    mapping = mirror_map()  # 1reate list of one-sided properties
    errors = 0
    # for each ring-property pair, ensure ring is symmetric for that property
    storage = []
    for ring in comm_rings:
        for pid in mapping.keys():
            rid = ring.ring_id
            RP1 = RingProperty.objects.filter(ring_id=rid, property_id=pid)
            RP2 = RingProperty.objects.filter(ring_id=rid, property_id=mapping[pid])
            if len(RP1) > 1:
                msg = 'symmetrize method discovered too many entries for ring_id %d with property_id %d' % (rid, pid)
                dlogger.warning(msg)
                errors += 1
                continue
            elif RP1 and RP2 and RP1[0].has_property != RP2[0].has_property:
                msg = 'symmetrize method ran into a symmetry conflict for ring_id %d with property_id %d' % (rid, pid)
                dlogger.warning(msg)
                errors += 1
                continue
            elif RP1 and not RP2:
                # insert appropriate entry into RingProperty
                storage.append(RingProperty(ring_id=rid, property_id=mapping[pid],
                                            has_property=RP1[0].has_property, reason='symmetry', poster='SymmScript'))
    counter = len(storage)
    for new_entry in storage:
        new_entry.save()
    print 'Done.'
    dlogger.info('SymmScript completed run and added %d entries.', counter)
    if errors > 0:
        dlogger.error('SymmScript encountered %d errors', errors)


def all_logic_forward(comm=False):
    """FwdLogicAll
    Loops through logic table entries filling out deductions about rings in database.
    Conflicts beween what the logic table says and what exists in the database are logged.
    """
    print 'Starting FwdLogicAll...'
    if comm is True:
        LogSupply = CommLogic
    else:
        LogSupply = Logic
    entries = LogSupply.objects.exclude(option='off').order_by('entry_type')
    counter = 0
    errors = 0
    for entry in entries:
        counter, errors = logic_forward(entry, counter, errors, comm=comm)
    msg = 'FwdLogicAll completed run and added %d entries to ring_property and encountered %d errors.' % (counter, errors)
    dlogger.info(msg)
    print 'Done.'


def single_logic_forward(r, comm=False, test=False):
    print 'Starting FwdLogicSingle...'
    if test is True:
        LogSupply = Logic
    elif comm is True:
        LogSupply = CommLogic
    else:
        LogSupply = Logic
    entries = LogSupply.objects.exclude(option='off').order_by('entry_type')
    counter = 0
    errors = 0
    for entry in entries:
        counter, errors = logic_forward(entry, counter, errors, override=[r], comm=comm, test=test)
    msg = 'FwdLogicSingle completed run adding %d entries and encountering %d errors.' % (counter, errors)
    dlogger.info(msg)
    print 'Done.'
    return counter, errors


def logic_forward(logic_entry, counter, errors, override=[], comm=False, test=False):
    """FwdLogicScript
    Logic script that applies a logic entry to one or many ring objects
    override is a list of ring objects
    When override is empty, it will do blanket pass over all rings
    """
    conds = [c for c in [logic_entry.cond_1, logic_entry.cond_2,
                         logic_entry.cond_3, logic_entry.cond_4] if c is not None]
    conc = logic_entry.conc
    if test is True:
        RPSupply = test_RingProperty
    elif comm is True:
        RPSupply = CommRingProperty
    else:
        RPSupply = RingProperty

    # Find rings satisfying conditions
    if override:
        candidates = [r for r in override if r in narrow_ring_search(has=conds, lacks=[], comm=comm, test=test)]
        conflicts = [r for r in override if r in narrow_ring_search(has=conds, lacks=[conc], comm=comm, test=test)]
    else:
        candidates = narrow_ring_search(has=conds, lacks=[], comm=comm, test=test)
        conflicts = narrow_ring_search(has=conds, lacks=[conc], comm=comm, test=test)
    # Remove candidates which conflict with logic entry
    update_ids = [ring.ring_id for ring in candidates if ring not in conflicts]
    for rid in update_ids:
        if not RPSupply.objects.filter(ring_id=rid, property_id=conc, has_property=1).exists():
            new = RPSupply(ring_id=rid, property_id=conc, has_property=1,
                           reason='logic_id=%d' % logic_entry.logic_id, poster='FwdLogicScript')
            new.save()
            counter += 1
        else:
            continue
    if conflicts and not test:
        dlogger.warning('FwdLogicScript reports conflict of logic_id %d with ring_ids %s', logic_entry.logic_id, str(conflicts))
        errors += len(conflicts)
    elif conflicts and test:
        print 'FwdLogicScript reports conflict of logic_id %d with ring_ids %s' % (logic_entry.logic_id, str(conflicts))
        errors += len(conflicts)
    return counter, errors


def new_single_logic_forward(ring, comm=False, test=False):
    """Processes a single ring with the Logic table (or the CommLogic table if comm=True)"""
    if test:
        logic_supply = Logic.objects.filter(option='on').order_by('entry_type')
        has_props = ring.test_ringproperty_set.filter(has_property=1)
        lacks_props = ring.test_ringproperty_set.filter(has_property=0)
        rp_model = test_RingProperty
        p_model = Property
        source = 'Logic id %d'
    elif comm:
        logic_supply = CommLogic.objects.filter(option='on').order_by('entry_type')
        has_props = ring.commringproperty_set.filter(has_property=1)
        lacks_props = ring.commringproperty_set.filter(has_property=0)
        rp_model = CommRingProperty
        p_model = CommProperty
        source = 'CommLogic id %d'
    else:
        logic_supply = Logic.objects.filter(option='on').order_by('entry_type')
        has_props = ring.ringproperty_set.filter(has_property=1)
        lacks_props = ring.ringproperty_set.filter(has_property=0)
        rp_model = RingProperty
        p_model = Property
        source = 'Logic id %d'

    has_props = set([prop.property_id for prop in has_props])
    lacks_props = set([prop.property_id for prop in lacks_props])
    candidates = []
    for logic in logic_supply:
        conds = [logic.cond_1, logic.cond_2, logic.cond_3, logic.cond_4]
        conds = filter(lambda x: x is not None, conds)
        conds = set(conds)
        conc = logic.conc
        if conds <= has_props:
            if conc in lacks_props:
                dlogger.error('Conflict of logic %s while processing %s.', str(logic.logic_id), ring)
                return -1
            elif conc not in has_props:
                new = rp_model(ring=ring, property=p_model.objects.get(property_id=conc), has_property=1,
                               reason='', source=source % logic.logic_id, poster='SingleLogicForward')
                candidates.append(new)
    for item in candidates:
        item.save()
    if comm is True:
        msg = ' (comm)'
    elif test is True:
        msg = ' (test)'
    else:
        msg = ''
    if test:
        print 'SingleLogicForward%s completed run adding %d entries.' % (msg, len(candidates))
    else:
        dlogger.info('SingleLogicForward%s completed run adding %d entries.', msg, len(candidates))
    return len(candidates)  # This will be used to stop iterations


def all_logic_backward(comm=False):
    """BkwdLogicAll
    Invokes logic_backward on all rings
    """
    if comm is True:
        LogSupply = CommLogic
    else:
        LogSupply = Logic
    print 'Starting BkwdLogicAll...'
    entries = LogSupply.objects.exclude(option='off').order_by('entry_type')
    entries = reversed(entries)
    counter = 0
    errors = 0
    for entry in entries:
        counter, errors = logic_backward(entry, counter, errors, comm=comm)
    msg = 'BkwdLogicAll completed run and inserted %d entries and encountered %d errors.' % (counter, errors)
    dlogger.info(msg)
    print 'Done.'


def logic_backward(logic_entry, counter, error, override=[], comm=False):
    """BkwdLogicScript
    Applies the logic entries as contrapositives
    Built for use with BkwdLogicAll and for use with individual rings
    """
    if comm is True:
        PropSupply = CommProperty
        RPSupply = CommRingProperty
    else:
        PropSupply = Property
        RPSupply = RingProperty
    type = logic_entry.entry_type
    conds = [logic_entry.cond_1, logic_entry.cond_2, logic_entry.cond_3, logic_entry.cond_4]
    conc = PropSupply.objects.get(pk=logic_entry.conc)
    print 'logic_id %d' % logic_entry.logic_id
    for r in Ring.objects.all():
        if RPSupply.objects.filter(ring=r, property=conc, has_property=0):
            counter, error = bkwd_atom(type, r, conds, logic_entry.logic_id, counter, error, comm=comm)
        else:
            pass
    return counter, error


def single_logic_backward(r, comm=False):
    if comm is True:
        LogSupply = CommLogic
        RPSupply = CommRingProperty
        PropSupply = CommProperty
    else:
        LogSupply = Logic
        RPSupply = RingProperty
        PropSupply = Property
    counter = 0
    error = 0
    print 'Starting BkwdLogicSingle on ring_id %d' % r.ring_id
    for L in LogSupply.objects.all():
        if RPSupply.objects.filter(ring=r, property=PropSupply.objects.get(pk=L.conc), has_property=0).exists():
            conds = [L.cond_1, L.cond_2, L.cond_3, L.cond_4]
            counter, error = bkwd_atom(L.entry_type, r, conds, L.logic_id, counter, error, comm=comm)
    msg = 'BkwdLogicSingle completed run. Inserted %d entries. Encountered %d errors.' % (counter, error)
    dlogger.info(msg)
    print 'Done.'


def bkwd_atom(type, r, conds, logic_id, counter, error, comm=False):
    """The ring that comes in must *not* have the conclusion
    take in conds as ids, determine what to enter as a result for that particular ring"""
    if comm is True:
        LogSupply = CommLogic
        RPSupply = CommRingProperty
        PropSupply = CommProperty
    else:
        LogSupply = Logic
        RPSupply = RingProperty
        PropSupply = Property

    signature = [None, None, None, None]
    for i in range(4):
        try:
            rp = RPSupply.objects.filter(ring=r.ring_id, property=PropSupply.objects.get(pk=conds[i]))
            signature[i] = rp[0].has_property
        except:
            signature[i] is None
        # signature is now a length four vector with entries 0,1, None
    if signature[0: type].count(None) != 1:
        pass
    elif type == 1:
        if signature == [1, None, None, None]:
            msg = 'BkwdLogicScript reports a logic conflict with ring_id %d and logic_id %d' % (r.ring_id, logic_id)
            dlogger.warning(msg)
            error += 1
        elif signature == [None, None, None, None]:
            c = PropSupply.objects.get(pk=conds[0])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        else:
            pass
            # print 'signature error for ring ', r,' logic_d=%d ' % logic_id
    elif type == 2:
        if signature == [1, 1, None, None]:
            msg = 'BkwdLogicScript reports a logic conflict with ring_id %d and logic_id %d' % (r.ring_id, logic_id)
            dlogger.warning(msg)
            error += 1
        elif signature == [None, 1, None, None]:
            c = PropSupply.objects.get(pk=conds[0])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        elif signature == [1, None, None, None]:
            c = PropSupply.objects.get(pk=conds[1])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        else:
            pass
            # print 'signature error for ring ', r,' logic_d=%d ' % logic_id
    elif type == 3:
        if signature == [1, 1, 1, None]:
            msg = 'BkwdLogicScript reports a logic conflict with ring_id %d and logic_id %d' % (r.ring_id, logic_id)
            dlogger.warning(msg)
            error += 1
        elif signature == [None, 1, 1, None]:
            c = PropSupply.objects.get(pk=conds[0])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        elif signature == [1, None, 1, None]:
            c = PropSupply.objects.get(pk=conds[1])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        elif signature == [1, 1, None, None]:
            c = PropSupply.objects.get(pk=conds[2])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        else:
            pass
            # print 'signature error for ring ', r,' logic_d=%d ' % logic_id
    elif type == 4:
        if signature == [1, 1, 1, 1]:
            msg = 'BkwdLogicScript reports a logic conflict with ring_id %d and logic_id %d' % (r.ring_id, logic_id)
            dlogger.warning(msg)
            error += 1
        elif signature == [None, 1, 1, 1]:
            c = PropSupply.objects.get(pk=conds[0])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        elif signature == [1, None, 1, 1]:
            c = PropSupply.objects.get(pk=conds[1])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        elif signature == [1, 1, None, 1]:
            c = PropSupply.objects.get(pk=conds[2])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        elif signature == [1, 1, 1, None]:
            c = PropSupply.objects.get(pk=conds[3])
            if not RPSupply.objects.filter(ring=r, property=c, has_property=0).exists():
                new = RPSupply(ring=r, property=c, has_property=0,
                               reason='logic_id=%d' % logic_id, poster='BkwdLogicScript')
                new.save()
                counter += 1
        else:
            pass
            # print 'signature error for ring ', r,' logic_d=%d ' % logic_id
    else:
        print 'Invalid logic type'
    return counter, error


# ### DIAGNOSTIC SCRIPTS ###

def hash_ring(ring, comm=False):
    """Compute a hash value for the properties this ring has for comparison
    with other rings' hashes. The hash is a ternary vector that records what
    properties are positive, negative and unknown"""
    if comm is True:
        prop_id_supply = [p.property_id for p in CommProperty.objects.all()]
        ring_prop_set = ring.commringproperty_set.all()
    else:
        prop_id_supply = [p.property_id for p in Property.objects.all()]
        ring_prop_set = ring.ringproperty_set.all()
    ring_prop_map = dict([(rp.property.property_id, rp.has_property) for rp in ring_prop_set])
    hashval = 0
    for pid in sorted(prop_id_supply):
        hashval *= 3
        hashval += ring_prop_map.get(pid, 2)
    return hashval


def hash_all_rings():
    """Compute hashes for all rings and create a dict with hashes as keys
    whose values are lists of rings with that hash"""
    rhash_dict = defaultdict(list)
    for ring in Ring.objects.all():
        rhash_dict[hash_ring(ring)].append(ring)
    return rhash_dict


def ring_profile(ring, comm=False):
    """Generate a ternary vector representing the ring's properties."""
    if comm is True:
        prop_id_supply = [p.property_id for p in CommProperty.objects.all()]
        ring_prop_set = ring.commringproperty_set.all()
    else:
        prop_id_supply = [p.property_id for p in Property.objects.all()]
        ring_prop_set = ring.ringproperty_set.all()
    ring_prop_map = dict([(rp.property.property_id, rp.has_property) for rp in ring_prop_set])
    ret_vec = []
    for pid in sorted(prop_id_supply):
        ret_vec.append(ring_prop_map.get(pid, 2))
    return ret_vec


def similarity_confidence(ring1, ring2, comm=False):
    """Returns a measure of similarity of the two rings. If there are records indicating
    they are different, return -1. Otherwise, return a ratio matching_attributes/total_attributes"""
    r_prof1 = ring_profile(ring1, comm=comm)
    r_prof2 = ring_profile(ring2, comm=comm)
    same = 0
    unsure = 0
    for i, k in enumerate(r_prof1):
        if (r_prof1[i] == 1 and r_prof2[i] == 0) or (r_prof1[i] == 0 and r_prof2[i] == 1):
            return -1
        elif r_prof1[i] == r_prof2[i] == 1 or r_prof1[i] == r_prof2[i] == 0:
            same += 1
        else:
            unsure += 1
    return float(same)/len(r_prof1)


def convert_to_comm(ring):
    """Lift entries in ring_property and put them in comm_ring_property for a single ring r
    """
    to_comm_map = pickle.load(open('to_comm_map.p', 'r'))
    rps = [prop for prop in ring.ringproperty_set.all()]
    crpids = [prop.property_id for prop in ring.commringproperty_set.all()]
    rps = [prop for prop in rps if prop.property_id in to_comm_map.keys()]
    new_rps = []
    for rp in rps:
        if to_comm_map[rp.property_id] not in crpids:
            comm_property = CommProperty.objects.get(pk=to_comm_map[rp.property_id])
            new = CommRingProperty(ring=ring, property=comm_property,
                                   has_property=rp.has_property,
                                   reason=rp.reason,
                                   source=rp.source,
                                   poster='ConvertScript')
            new_rps.append(new)
    errors = 0
    successes = 0
    for rp in new_rps:
        try:
            rp.save()
            successes += 1
        except:
            dlogger.error('Error saving new entry in convertscript: %s', rp)
    dlogger.info('ConvertScript completed run on %s. Added %s entries.', ring, str(successes))
    print 'Done converting', ring


def suggestions1():
    """Indicate where examples are needed for asymmetric conditions"""
    mapping = half_mirror_map()
    for key in mapping.keys():
        if len(find_rings('n', has=[key], lacks=[mapping[key]])) == 0 and len(find_rings('n', has=[mapping[key]],
                                                                                         lacks=[key])) == 0:
            print 'Need a ring that is %s and not %s' % (Property.objects.get(pk=key).name,
                                                         Property.objects.get(pk=mapping[key]).name)


def suggestions2(comm=False):
    """Indicate where examples are needed for simple implications"""
    mapping = mirror_map_2()
    if comm is True:
        LogSupply = CommLogic.objects.filter(entry_type=1, option='on')
        PropSupply = CommProperty.objects
    else:
        lefts = Property.objects.filter(name__endswith='(left)')
        lefts = [x.property_id for x in lefts]
        LogSupply = Logic.objects.filter(entry_type=1, option='on').exclude(cond_1__in=lefts)
        PropSupply = Property.objects
    candidates = []

    for item in LogSupply:
        # print item.logic_id
        if comm is True and not find_rings(scope='n', has=[item.conc], lacks=[item.cond_1], comm=True).exists():
            candidates.append("Need a commutative ring that is %s but not %s" % (PropSupply.get(pk=item.conc),
                                                                                 PropSupply.get(pk=item.cond_1)))
        elif comm is False and not find_rings(scope='n', has=[item.conc], lacks=[item.cond_1]).exists() \
                and not mirror_search(scope='n', has=[item.conc], lacks=[item.cond_1]).exists():
            candidates.append("Need a ring that is %s but not %s" % (PropSupply.get(pk=item.conc),
                                                                     PropSupply.get(pk=item.cond_1)))
        else:
            pass
    if comm is True:
        outfile = 'ringapp/generated/cring_sugg.txt'
    else:
        outfile = 'ringapp/generated/ring_sugg.txt'
    with open(outfile, 'w') as f:
        for x in candidates:
            f.write(x+'\r\n')
