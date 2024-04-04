from django.db import models, transaction
from django.core.exceptions import ValidationError
from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _
from publications import models as pmodels

import textwrap

from ringapp.constants import sidetype_choices
from datalog.souffle_utils import logic_to_rulelist, ring_mirror

from typing import List


def symmetrize_sides(rp):
    if rp.has_on_left is not None and rp.has_on_right is None:
        rp.has_on_right = rp.has_on_left
        rp.reason_right = 'symmetry with left side'

    elif rp.has_on_right is not None and rp.has_on_left is None:
        rp.has_on_left = rp.has_on_right
        rp.reason_left = rp.reason_right
        rp.reason_left = 'symmetry with right side'

    elif rp.has_on_left == rp.has_on_right:
        pass
    else:
        raise ValidationError(_('Something attempted to record asymmetric '
                                'RingProperty record for a symmetric property: '
                                'ring={} property={}'.format(rp.ring, rp.property)))

# Django models


class Keyword(models.Model):
    name = models.CharField(max_length=50)
    description = models.TextField(max_length=400, null=True, blank=True)

    class Meta:
        ordering = ('name', )

    def __str__(self):
        return self.name


class Publication(pmodels.Publication):
    class Meta:
        db_table = 'publications_publication'
        managed = False
        proxy = True
        ordering = ['authors', 'title']

    def __str__(self):
        return '{}. {}. ({})'.format(self.authors, self.title, self.year)

    @property
    def author_lasts(self):
        if ',' not in self.authors and ' and ' in self.authors:
            author_lasts = self.authors.split(' and ')
        elif ',' in self.authors:
            author_lasts = self.authors.split(', ')
        else:
            author_lasts = [self.authors]
        if author_lasts[-1].startswith('and '):
            author_lasts[-1] = author_lasts[-1][4:]
        author_lasts = [x.split(' ')[-1] for x in author_lasts]
        if len(author_lasts) == 1:
            author_string = author_lasts[0]
        elif len(author_lasts) == 2:
            author_string = ' and '.join(author_lasts)
        else:
            author_lasts[-1] = 'and ' + author_lasts[-1]
            author_string = ', '.join(author_lasts)
        return author_string


class Citation(models.Model):
    publication = models.ForeignKey('ringapp.Publication', on_delete=models.CASCADE)
    location = models.CharField(max_length=128)

    class Meta:
        ordering = ('publication__authors', 'publication__title')

    def __str__(self):
        return '{} @ {}'.format(self.publication, self.location)


class Property(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)
    symmetric = models.BooleanField(null=True)
    commutative_only = models.BooleanField(default=False)
    citation = models.ManyToManyField('Citation', blank=True)

    class Meta:
        verbose_name_plural = 'Properties'
        ordering = ('name',)

    def __str__(self):
        return self.name


class PropertySide(models.Model):
    class Meta:
        verbose_name_plural = 'Property-side pairings'
        unique_together = (('property', 'side'),)
        ordering = ('property', 'side')

    property = models.ForeignKey('Property', on_delete=models.CASCADE)
    side = models.SmallIntegerField(choices=sidetype_choices)

    def clean(self):
        """
        Prevent symmetric properties from being associated with sides
        """
        if self.property.symmetric:
            self.side = 0
            self.save()

    def __str__(self):
        value = self.property.name
        if self.side != 0:
            value += ' on the {}'.format(self.get_side_display())

        return value


class Logic(models.Model):
    hyps = models.CharField(max_length=255, null=True, blank=False)
    concs = models.CharField(max_length=255, null=True, blank=False)
    variety = models.PositiveSmallIntegerField(choices=[(0, '===>'), (1, '<==>')], null=True)
    symmetric = models.BooleanField(null=True)
    citation = models.ManyToManyField('Citation', blank=True)

    active = models.BooleanField(default=True)

    def __str__(self):
        return f'{self.hyps} {self.get_variety_display()} {self.concs}'

    def __repr__(self):
        return '<Logic: id={}>'.format(id(self))

    def to_souffle(self) -> List[str]:
        """
        A list of lines to use in a souffle-style datalog program that includes all
        inferential rules based on this logic.
        """
        hyps = self.hyps.split(' AND ')
        concs = self.concs.split(' AND ')

        if self.variety == 1:
            ruleset = logic_to_rulelist(hyps, concs) | logic_to_rulelist(concs, hyps)
        else:
            ruleset = logic_to_rulelist(hyps, concs)

        if hasattr(self, 'symmetric') and self.symmetric is False:
            ruleset |= ring_mirror(ruleset)

        ruleset.discard('')
        rulelist = list(sorted(map(lambda x: x + f'  // logic {self.id}', ruleset)))
        return rulelist


class Theorem(models.Model):
    alias = models.CharField(max_length=100, null=True, blank=True)
    statement = models.TextField(max_length=1000)
    categories = models.ManyToManyField('TheoremCategory', blank=True)
    citation = models.ManyToManyField('Citation', blank=True)
    link = models.URLField(blank=True, null=True)
    commutative_only = models.BooleanField(default=False)

    def __str__(self):
        if self.alias:
            return self.alias
        else:
            return textwrap.shorten(self.statement, width=1000)


class TheoremCategory(models.Model):
    name = models.CharField(max_length=64)
    description = models.CharField(max_length=256, blank=True)

    def __str__(self):
        return self.name


class Ring(models.Model):
    name = models.CharField(max_length=250)
    description = models.TextField(max_length=1000)
    keywords = models.ManyToManyField('Keyword', blank=True)
    notes = models.CharField(max_length=500, blank=True, null=True)
    citation = models.ManyToManyField('Citation', blank=True)

    krull_dim = models.CharField(max_length=16, default='(unknown)', blank=True, null=True)
    is_commutative = models.BooleanField(null=True)

    optional_template = models.CharField(max_length=128, blank=True, default='')

    class Meta:
        ordering = ('name',)

    def __str__(self):
        return self.name


class RingProperty(models.Model):
    ring = models.ForeignKey('Ring', on_delete=models.CASCADE)
    property = models.ForeignKey('Property', on_delete=models.CASCADE)
    has_on_left = models.BooleanField(null=True)
    reason_left = models.CharField(max_length=200, blank=True, null=True)
    citation_left = models.ManyToManyField('Citation', related_name='citation_left', blank=True)
    has_on_right = models.BooleanField(null=True)
    reason_right = models.CharField(max_length=200, blank=True, null=True)
    citation_right = models.ManyToManyField('Citation', related_name='citation_right', blank=True)

    class Meta:
        verbose_name_plural = 'Ring-property relationships'
        unique_together = (('ring', 'property'),)

    def clean(self):
        if self.ring.is_commutative or self.property.symmetric:
            symmetrize_sides(self)
            self.save()

        if self.property.name == 'commutative' and self.has_on_left is True:
            if self.ring.is_commutative is None:
                self.ring.is_commutative = True
                self.ring.save()
            elif self.ring.is_commutative is False:
                raise ValidationError('ring.is_commutative attribute contradicts '
                                      'this ring-property relationship.')

    def __str__(self):
        return '({}-{}) has on left:{} has on right:{}'\
            .format(self.ring, self.property, self.has_on_left, self.has_on_right)


class Dimension(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)
    symmetric = models.BooleanField(null=True)

    def __str__(self):
        return '{}'.format(self.name)


class Subset(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)

    def __str__(self):
        return '{}'.format(self.name)


class RingDimension(models.Model):
    ring = models.ForeignKey(Ring, on_delete=models.CASCADE)
    dimension_type = models.ForeignKey(Dimension, on_delete=models.CASCADE)
    left_dimension = models.CharField(max_length=16, help_text='Indicates magnitude of dimension.', blank=True)
    right_dimension = models.CharField(max_length=16, help_text='Indicates magnitude of dimension.', blank=True)
    citation = models.ManyToManyField('Citation', blank=True)
    reason_left = models.CharField(max_length=200, blank=True, null=True)
    reason_right = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        unique_together = (('ring', 'dimension_type'),)

    def __str__(self):
        if self.dimension_type.symmetric:
            return '{} {}={}'.format(self.ring, self.dimension_type, self.left_dimension)
        else:
            return '{0} left {1}={2} right {1}={3}'.format(self.ring,
                                                           self.dimension_type.name,
                                                           self.left_dimension,
                                                           self.right_dimension)


class RingSubset(models.Model):
    ring = models.ForeignKey(Ring, on_delete=models.CASCADE)
    subset_type = models.ForeignKey(Subset, on_delete=models.CASCADE)
    subset = models.CharField(max_length=512, help_text='Describes the elements in the indicated subset.')
    citation = models.ManyToManyField('Citation', blank=True)
    reason = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        unique_together = (('ring', 'subset_type'),)

    def __str__(self):
        return '{}: {}'.format(self.ring, self.subset_type.name)


class Relation(models.Model):
    class Meta:
        unique_together = (('first', 'second', 'relation_type'),)

    class RelationType(models.TextChoices):
        NONE = 'NONE', _('(error)')
        SUB_OF = 'SUBRING_OF', _('is a subring of')
        IM_OF = 'IMAGE_OF', _('is a homomorphic image of')
        LOC_OF = 'LOCALIZATION_OF', _('is a localization of')
        CORNER_OF = 'CORNER_OF', _('is a corner ring of')
        FULL_CORNER_OF = 'FULL_CORNER_OF', _('is a full corner ring of')
        COMP_OF = 'COMPLETION_OF', _('is the completion of')
        INT_CLOS_OF = 'INTEGRAL_CLOSURE_OF', _('is the integral closure of')
        QUOTIENTS_OF = 'RING_OF_QUOTIENTS_OF', _('is the full ring of quotients of')
        CENTER_OF = 'CENTER_OF', _('is the center of')
        POLY_RING_OF = 'POLYNOMIAL_RING_OF', _('is the polynomial ring of')
        MAT_RING_OF = 'MATRIX_RING_OF', _('is a matrix ring of')
        FIN_GEN_OVER = 'FG_ALGEBRA_OVER', _('is a finitely generated algebra over')
        MORITA_EQ_TO = 'MORITA_EQ_TO', _('is Morita equivalent to')
        POW_SER_OF = 'POWER_SERIES_OF', _('is the power series ring of')

    first = models.ForeignKey(Ring, related_name='first_ring', on_delete=models.CASCADE)
    relation_type = models.CharField(max_length=32, choices=RelationType.choices, default=RelationType.NONE)
    second = models.ForeignKey(Ring, related_name='second_ring', on_delete=models.CASCADE)
    note = models.TextField(max_length=400, null=True, blank=True)

    def __str__(self):
        return f"{self.first.id} {self.get_relation_type_display()} {self.second.id}"


class Metaproperty(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)
    relation_type = models.CharField(max_length=32, choices=Relation.RelationType.choices, default=Relation.RelationType.NONE)

    class Meta:
        verbose_name_plural = 'Metaproperties'
        ordering = ('name',)

    def __str__(self):
        return self.name


class PropertyMetaproperty(models.Model):
    property = models.ForeignKey('Property', on_delete=models.CASCADE)
    metaproperty = models.ForeignKey('Metaproperty', on_delete=models.CASCADE)
    has_metaproperty = models.BooleanField(null=True)
    example = models.ForeignKey('Ring', blank=True, null=True, on_delete=models.CASCADE)
    relation = models.ForeignKey('Relation', blank=True, null=True, on_delete=models.CASCADE)
    citation = models.ManyToManyField('Citation', blank=True)

    commutative_only = models.BooleanField(default=False)

    class Meta:
        verbose_name_plural = 'Property-metaproperty relationships'
        unique_together = (('property', 'metaproperty'), )

    def __str__(self):
        if self.has_metaproperty:
            return "%s : %s" % (self.property.name, self.metaproperty.name)
        else:
            return "%s : not %s" % (self.property.name, self.metaproperty.name)


# class Glossary(models.Model):
#     term = models.CharField(max_length=100, blank=True, null=True)
#     definition = models.CharField(max_length=400, blank=True, null=True)
#     reference = models.ManyToManyField(Citation, verbose_name="glossary reference", blank=True)
#
#     class Meta:
#         verbose_name_plural = 'Glossary entries'
#
#     def __str__(self):
#         return self.term
#
#
# class FAQ(models.Model):
#     question = models.CharField(max_length=200, blank=True, null=True)
#     answer = models.CharField(max_length=400, blank=True, null=True)
#
#     def __str__(self):
#         return self.question


class Erratum(models.Model):
    error_location = models.ForeignKey('Citation', related_name='error_location',
                                       help_text='Where the original erroneous statement appeared.', on_delete=models.CASCADE)
    description = models.TextField(max_length=400, blank=True, help_text='A description of the faulty claim and useful '
                                                                         'information about correcting it.')
    corrected_location = models.ManyToManyField('Citation', related_name='corrected_location',
                                                help_text='References which correct the statement.')
    example = models.ForeignKey('Ring', null=True, help_text='A ring acting as a counterexample to the erroneous '
                                                             'statement.', blank=True, on_delete=models.CASCADE)

    class Meta:
        verbose_name_plural = 'Errata'

    def __str__(self):
        return '<{} - {}>'.format(self.error_location, self.description[:100])


def format_pub(pub):
    s = '{}'.format(pub.authors)
    s += '. {}.'.format(pub.title)
    if pub.journal:
        s += ' {}'.format(pub.journal)
    if pub.note:
        s += ' {}'.format(pub.note)
    if pub.volume:
        s += 'Vol {}'.format(pub.volume)
    if pub.number:
        s += ' ({})'.format(pub.number)

    if pub.pages:
        s += ' {}'.format(pub.pages)

    if pub.publisher:
        s += ' {}'.format(pub.publisher)
    s += ', {}'.format(pub.year)
    return s


@receiver(pre_save, sender=RingProperty)
def symmetrize(sender, instance, *args, **kwargs):
    if instance.ring.is_commutative or instance.property.symmetric:
        symmetrize_sides(instance)


@receiver(pre_save, sender=RingDimension)
def symmetrize_dimension(sender, instance, *args, **kwargs):
    if instance.ring.is_commutative or instance.dimension_type.symmetric:
        if not instance.left_dimension and instance.right_dimension:
            instance.left_dimension = instance.right_dimension
        elif not instance.right_dimension and instance.left_dimension:
            instance.right_dimension = instance.left_dimension
        elif (instance.right_dimension and instance.left_dimension and
              instance.right_dimension != instance.left_dimension):
            raise ValidationError('The {} measurements for {} ought to match.'.format(instance.dimension_type.name,
                                                                                      instance.ring))


@receiver(post_save, sender=Relation)
def propagate_relation(sender, instance, *args, **kwargs):
    if instance.relation_type == Relation.RelationType.NONE:
        return
    mp = Metaproperty.objects.filter(relation_type=instance.relation_type).first()
    if mp is None:
        return

    # For drawing negative conclusions about metaproperties
    # These two lists contain properties the related rings disagree on
    lps = {x.property for x in instance.first.ringproperty_set.filter(has_on_left=False)} & {
        x.property for x in instance.second.ringproperty_set.filter(has_on_left=True)}
    rps = {x.property for x in instance.first.ringproperty_set.filter(has_on_right=False)} & {
        x.property for x in instance.second.ringproperty_set.filter(has_on_right=True)}

    props = lps | rps

    with transaction.atomic():
        count = 0
        for prop in props:
            pmp, _ = PropertyMetaproperty.objects.get_or_create(property=prop, metaproperty=mp)

            if pmp.has_metaproperty is True:
                raise Exception(f"Contradiction of PropertyMetaproperty data {pmp} with relation {instance}")

            changed = False
            if not pmp.relation:
                pmp.relation = instance
                changed = True
            if pmp.has_metaproperty is not False:
                pmp.has_metaproperty = False
                changed = True
            if changed is True:
                pmp.save()
                count += 1
    print(f"Relation post-save for {instance=} updated {count=}")
