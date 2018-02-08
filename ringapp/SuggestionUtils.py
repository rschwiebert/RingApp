from django.http.request import QueryDict
from django.shortcuts import reverse
from sympy.logic.inference import satisfiable
from ringapp.forms import term_to_readable
from ringapp.models import Property, Logic
from ringapp.LogicUtils import LogicEngine
from ringapp.SearchUtils import ring_search, mirror_search_terms


def suggest_new_example(logic, assume_commutative=False):
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


def simple_irreversible_logics(commutative=False):
    logics = Logic.objects.filter(variety=0)
    results = []
    for logic in logics:
        if logic.hyps.count() > 1:
            continue
        if logic.concs.count() > 1:
            continue
        result = suggest_new_example(logic, assume_commutative=commutative)
        if not result:
            continue

        has, lacks, url = result[0]
        results.append(('is {} and is not {}'.format(has[0][0], lacks[0][0]), url))
    return results
