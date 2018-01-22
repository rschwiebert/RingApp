import logging
from django.core.cache import cache
from sympy import And
from sympy.logic.boolalg import BooleanTrue, BooleanFalse
from ringapp.LogicUtils import LogicEngine
from ringapp.models import Ring, Property

log = logging.getLogger(__name__)


def detect_asymmetric_search(terms):
    """
    Determine if the search needs to take side into consideration.
    :param terms: List of strings matching (H|L)[0-9]+(l|r)? 
                  <has/lacks><ringid>[<left/right>]
    :return: True if sides are needed, false otherwise
    """
    commutative = Property.objects.get(name='commutative')
    return 'H{}'.format(commutative.id) not in terms and \
           any([x for x in terms if x.endswith('l') or x.endswith('r')])


def mirror_search_terms(terms):
    """
    Interchange the sidedness of a query
    :param terms: List of strings matching (H|L)[0-9]+(l|r)? 
                  <has/lacks><ringid>[<left/right>]
    :return: The same terms with occurrences of 'left' and 'right' interchanged
    """
    terms = [term.replace('l', 'Q').replace('r', 'l').replace('Q', 'r') for term in terms]
    return terms


def get_search_expression(terms):
    """
    Return logical expression in sympy boolean algebra for search expression
    :param terms: List of strings matching (H|L)[0-9]+(l|r)? 
                  <has/lacks><ringid>[<left/right>]
    :return: A logical statement in PROPERTY_SYMBOL_MAP variables
    """
    log_eng = LogicEngine()
    term_to_symbol = log_eng.term_to_symbol
    has_props = [term[1:] for term in terms if term.startswith('H')]
    has_props = [term_to_symbol[term] for term in has_props]

    lacks_props = [term[1:] for term in terms if term.startswith('L')]
    lacks_props = [~term_to_symbol[term] for term in lacks_props]

    props = has_props + lacks_props
    search_expression = And(*props)
    return search_expression


def ring_search(terms):
    """
    Return two lists of Ring objects based on search parameters
    :param terms: List of strings matching (H|L)[0-9]+(l|r)? 
                  <has/lacks><ringid>[<left/right>]
    :return: a pair of lists of Ring objects. The first one contains definite matches, 
             the second contains potential matches
    """
    log.info('Search request: {}'.format(terms))
    repo = LogicEngine()
    search_expr = get_search_expression(terms)
    hits = []
    maybes = []
    for ring in Ring.objects.all():
        known_props = cache.get('ring_props:{}'.format(ring.id))
        if known_props is None:
            repo.load_ringproperties(ring)
            known_props = cache.get('ring_props:{}'.format(ring.id))
        check = search_expr.subs(known_props)
        if isinstance(check, BooleanTrue):
            hits.append(ring)
        elif isinstance(check, BooleanFalse):
            pass
        elif check.is_Boolean or check.is_Symbol:
            maybes.append(ring)
        else:
            log.error('Failed substitution check on expression {} '
                      'ring property cache was {}'.format(search_expr,
                                                          known_props))
    log.debug('Returned {} hits and {} maybes'.format(len(hits), len(maybes)))
    return hits, maybes


def completeness_scores(include_commutative=False):
    """
    Provide a dict with the completeness scores of rings in database
    :param include_commutative: if False, it will filter out the specialized
                        commutative Properties. If True, it will include
                        all Properties.
    :return: A dict keyed by Ring ids providing scores for each Ring
    """
    query = """
        SELECT id,
               sum(score)
        FROM
          (SELECT "ringapp_ringproperty"."ring_id" AS id,
                  CASE
                      WHEN "ringapp_property"."symmetric" IS TRUE
                           AND "ringapp_ringproperty"."has_on_left" IS NOT NULL THEN 1
                      WHEN "ringapp_property"."symmetric" IS TRUE
                           AND "ringapp_ringproperty"."has_on_left" IS NULL THEN 0
                      WHEN "ringapp_property"."symmetric" IS FALSE THEN ("ringapp_ringproperty"."has_on_left" IS NOT NULL)::int + ("ringapp_ringproperty"."has_on_right" IS NOT NULL)::int
                  END AS score
           FROM "ringapp_ringproperty"
           INNER JOIN "ringapp_property" ON ("ringapp_ringproperty"."property_id" = "ringapp_property"."id")
           {}) AS t1
        GROUP BY id
        """
    if include_commutative is False:
        query = query.format('WHERE "ringapp_property"."commutative_only" = FALSE')
    else:
        query = query.format('')
    query = Ring.objects.raw(query)
    data = {ring.id: ring.sum for ring in query}
    for key, datum in data.items():
        if datum is None:
            data[key] = 0
    return data
