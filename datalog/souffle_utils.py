import re
from pathlib import Path
from typing import List, Set

import datalog

DL_DIR = Path(datalog.__path__[0])
TEMPLATES = DL_DIR/'templates'


class NegationException(Exception):
    """When we can't negate a souffle predicate"""
    pass


def negate(relation: str) -> str:
    """
    Attempt to negate the relation provided
    :param relation: a souffle relation expression like table(x, y, z)
    :return: relation expressing the negation of the original
    """
    pat = re.compile('(ring_deduced|module_deduced)\("(has|lacks)"')
    mat = pat.search(relation)
    if mat is None:
        raise NegationException()
    if mat.group(2) == 'has':
        return re.sub(f'{mat.group(1)}\("has"', f'{mat.group(1)}("lacks"', relation)

    elif mat.group(2) == 'lacks':
        return re.sub(f'{mat.group(1)}\("lacks"', f'{mat.group(1)}("has"', relation)

    else:
        raise NegationException()


def logic_to_rulelist(hyps: List[str], concs: List[str]) -> Set[str]:
    if len(concs) > 1:
        rulelist = set()
        for conc in concs:
            rulelist = rulelist.union(logic_to_rulelist(hyps, [conc]))
        return rulelist

    conc = concs[0]
    firstrule = f"{conc}:-{','.join(hyps)}."
    rulelist = [firstrule, ]
    for i, hyp in enumerate(hyps):
        otherhyps = hyps[:i] + hyps[i+1:]
        try:
            if otherhyps:
                rulelist.append(f"{negate(hyp)}:-{negate(conc)},{','.join(otherhyps)}.")
            else:
                rulelist.append(f"{negate(hyp)}:-{negate(conc)}.")
        except NegationException:
            print(f"One of {hyp} or {conc} failed to negate. Either we need to add code or it is not possible.")
            continue

    return set(rulelist)


def ring_mirror(inputset: Set[str]) -> Set[str]:
    inputstring = '\n'.join(inputset)
    return set((inputstring
                .replace('"has",2', '"has",#')
                .replace('"has",3', '"has",2')
                .replace('"has",#', '"has",3')
                .replace('"lacks",2', '"lacks",#')
                .replace('"lacks",3', '"lacks",2')
                .replace('"lacks",#', '"lacks",3')
                ).split('\n'))


def write_ring_properties(ring, complete=True):
    known = ring.ringproperty_set.all()
    if complete is False:
        known = known \
            .exclude(reason_left__startswith='Logic') \
            .exclude(reason_right__startswith='Logic')
    with open(DL_DIR/'inputs'/'ring_known.facts', 'w') as f:
        for rp in known:
            if rp.property.symmetric is True:
                if rp.has_on_left is True:
                    f.write(f'has\t0\t{rp.property.id}\n')
                if rp.has_on_left is False:
                    f.write(f'lacks\t0\t{rp.property.id}\n')
            else:
                if rp.has_on_left is True:
                    f.write(f'has\t2\t{rp.property.id}\n')
                if rp.has_on_left is False:
                    f.write(f'lacks\t2\t{rp.property.id}\n')
                if rp.has_on_right is True:
                    f.write(f'has\t3\t{rp.property.id}\n')
                if rp.has_on_right is False:
                    f.write(f'lacks\t3\t{rp.property.id}\n')


def write_module_properties(module, complete=True):
    known = module.moduleproperty_set.all()
    if complete is False:
        known = known.exclude(reason__startswith='Logic')
    with open(DL_DIR/'inputs'/'module_known.facts', 'w') as f:
        for mp in known:
            if mp.has is True:
                f.write(f'has\t{mp.property.id}\n')
            if mp.has is False:
                f.write(f'lacks\t{mp.property.id}\n')


def write_ring_dims(ring, complete=True):
    known = ring.ringdimension_set.all()
    if complete is False:
        known = known \
            .exclude(reason_left__startswith='Logic') \
            .exclude(reason_right__startswith='Logic')

    with open(DL_DIR/'inputs'/'ring_dim_known.facts', 'w') as f:
        for rd in known:
            if rd.left_dimension != '':
                f.write(f'{rd.left_dimension}\t2\t{rd.dimension_type.id}\n')

            if rd.right_dimension != '':
                f.write(f'{rd.right_dimension}\t3\t{rd.dimension_type.id}\n')
