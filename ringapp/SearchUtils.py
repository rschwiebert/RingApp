import logging
from typing import Tuple, List

from django.db.models import Q, QuerySet
from ringapp.models import Ring, Property, RingProperty
import moduleapp.models

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


def ring_search(terms: List[str]) -> Tuple[QuerySet, QuerySet]:
    """
    Return two lists of Ring objects based on search parameters
    :param terms: List of strings matching (H|L)[0-9]+(l|r)? 
                  <has/lacks><ringid>[<left/right>]
    :return: a pair of lists of Ring objects. The first one contains definite matches, 
             the second contains potential matches
    """
    log.debug('Search request: {}'.format(terms))
    narrow = Ring.objects.all()
    wide = Ring.objects.all()

    for term in terms:
        qsn = RingProperty.objects.all()
        qsw = RingProperty.objects.all()
        if term[0] == 'H':
            if term[-1] == 'l':
                qsw = qsw.filter(property_id=term[1:-1], has_on_left=False)
                qsn = qsn.filter(property_id=term[1:-1], has_on_left=True)
            elif term[-1] == 'r':
                qsw = qsw.filter(property_id=term[1:-1], has_on_right=False)
                qsn = qsn.filter(property_id=term[1:-1], has_on_right=True)
            else:
                qsw = qsw.filter(Q(property_id=term[1:], has_on_left=False) |
                                 Q(property_id=term[1:], has_on_right=False))
                qsn = qsn.filter(Q(property_id=term[1:], has_on_left=True) |
                                 Q(property_id=term[1:], has_on_right=True))
        elif term[0] == 'L':
            if term[-1] == 'l':
                prop_id = term[1:-1]
                qsw = qsw.filter(property_id=prop_id, has_on_left=True)
                qsn = qsn.filter(property_id=prop_id, has_on_left=False)
            elif term[-1] == 'r':
                prop_id = term[1:-1]
                qsw = qsw.filter(property_id=prop_id, has_on_right=True)
                qsn = qsn.filter(property_id=prop_id, has_on_right=False)
            else:
                prop_id = term[1:]
                qsw = qsw.filter(Q(property_id=prop_id, has_on_left=True) |
                                 Q(property_id=prop_id, has_on_right=True))
                qsn = qsn.filter(Q(property_id=prop_id, has_on_left=False) |
                                 Q(property_id=prop_id, has_on_right=False))
        else:
            raise Exception('Invalid search term encountered.')

        w_ids = qsw.values_list('ring_id', flat=True)
        wide = wide.exclude(id__in=w_ids)

        n_ids = qsn.values_list('ring_id', flat=True)
        narrow = narrow.filter(id__in=n_ids)

    wide = wide.exclude(id__in=[ring.id for ring in narrow])
    log.debug('Returned {} hits and {} maybes'.format(narrow.count(), wide.count()))
    return narrow, wide


def module_search(terms):
    """
    Return two lists of Module objects based on search parameters
    :param terms: List of strings matching (H|L)[0-9]+
                  <has/lacks><propertyid>
    :return: a pair of lists of Module objects. The first one contains definite matches,
             the second contains potential matches
    """
    log.debug('Search request: {}'.format(terms))
    narrow = moduleapp.models.Module.objects.all()
    wide = moduleapp.models.Module.objects.all()

    for term in terms:
        qsn = moduleapp.models.ModuleProperty.objects.all()
        qsw = moduleapp.models.ModuleProperty.objects.all()
        if term[0] == 'H':
            qsw = qsw.filter(property_id=term[1:], has=False)
            qsn = qsn.filter(property_id=term[1:], has=True)
        elif term[0] == 'L':
            qsw = qsw.filter(property_id=term[1:], has=True)
            qsn = qsn.filter(property_id=term[1:], has=False)
        else:
            raise Exception('Invalid search term encountered.')

        w_ids = qsw.values_list('module_id', flat=True)
        wide = wide.exclude(id__in=w_ids)

        n_ids = qsn.values_list('module_id', flat=True)
        narrow = narrow.filter(id__in=n_ids)

    wide = wide.exclude(id__in=[module.id for module in narrow])
    log.debug('Returned {} hits and {} maybes'.format(narrow.count(), wide.count()))
    return narrow, wide


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
               sum(score) as sum
        FROM
          (SELECT "ringapp_ringproperty"."ring_id" AS id,
                  CASE
                      WHEN "ringapp_property"."symmetric" IS TRUE
                           AND "ringapp_ringproperty"."has_on_left" IS NOT NULL THEN 1
                      WHEN "ringapp_property"."symmetric" IS TRUE
                           AND "ringapp_ringproperty"."has_on_left" IS NULL THEN 0
                      WHEN "ringapp_property"."symmetric" IS FALSE THEN CAST("ringapp_ringproperty"."has_on_left" IS NOT NULL AS INT) + CAST("ringapp_ringproperty"."has_on_right" IS NOT NULL AS INT)
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

def property_completeness_scores(commutative_only=False):
    """
    Provide a dict with the completeness scores of properties in database
    :param commutative_only: if False, it will include all Rings. If
                        True, it will include only the specialized
                        commutative Rings.
    :return: A dict keyed by Property ids providing scores for each Property
    """
    query = """
        SELECT id,
               sum(score) as sum
        FROM
          (SELECT "ringapp_ringproperty"."property_id" AS id,
                  CASE
                      WHEN "ringapp_ring"."is_commutative" IS TRUE
                           AND "ringapp_ringproperty"."has_on_left" IS NOT NULL THEN 1
                      WHEN "ringapp_ring"."is_commutative" IS TRUE
                           AND "ringapp_ringproperty"."has_on_left" IS NULL THEN 0
                      WHEN "ringapp_ring"."is_commutative" IS NOT TRUE
                           AND "ringapp_property"."commutative_only" IS TRUE THEN 0
                      WHEN "ringapp_ring"."is_commutative" IS NOT TRUE
                           AND "ringapp_property"."commutative_only" IS NOT TRUE THEN
                           CAST("ringapp_ringproperty"."has_on_left" IS NOT NULL AS INT) + CAST("ringapp_ringproperty"."has_on_right" IS NOT NULL AS INT)
                  END AS score
           FROM "ringapp_ringproperty"
           INNER JOIN "ringapp_ring" ON ("ringapp_ringproperty"."ring_id" = "ringapp_ring"."id")
           INNER JOIN "ringapp_property" ON ("ringapp_ringproperty"."property_id" = "ringapp_property"."id")
           {}) AS t1
        GROUP BY id
        """
    if commutative_only is True:
        query = query.format('WHERE "ringapp_ring"."is_commutative" = TRUE')
    else:
        query = query.format('')
    query = Property.objects.raw(query)
    data = {property.id: property.sum for property in query}
    for key, datum in data.items():
        if datum is None:
            data[key] = 0
    return data
