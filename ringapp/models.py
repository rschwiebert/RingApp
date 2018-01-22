from django.db import models
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.db.models.signals import pre_save
from django.dispatch import receiver
from django.utils.translation import ugettext_lazy as _
from publications import models as pmodels

import textwrap


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
    publication = models.ForeignKey('ringapp.Publication')
    location = models.CharField(max_length=128)
    user = models.ForeignKey(User, blank=True, null=True)

    class Meta:
        ordering = ('publication__authors', 'publication__title')

    def __str__(self):
        return '{} @ {}'.format(self.publication, self.location)


class Property(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)
    symmetric = models.NullBooleanField()
    commutative_only = models.BooleanField(default=False)
    user = models.ForeignKey(User, blank=True, null=True)

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

    property = models.ForeignKey('Property')
    side = models.SmallIntegerField(choices=[(0, ''),
                                             (1, 'left and right'),
                                             (2, 'left'),
                                             (3, 'right'),
                                             (4, 'left or right'), ])

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
    hyps = models.ManyToManyField('PropertySide', related_name='hypotheses', verbose_name="hypotheses")
    concs = models.ManyToManyField('PropertySide', related_name='conclusions', verbose_name="conclusions")
    variety = models.PositiveSmallIntegerField(choices=[(0, '===>'), (1, '<==>')], null=True)
    symmetric = models.NullBooleanField()
    citation = models.ManyToManyField('Citation', blank=True)

    user = models.ForeignKey(User, blank=True, null=True)
    active = models.BooleanField(default=True)

    def __str__(self):
        hyps = ' and '.join([str(rp) for rp in self.hyps.all()])
        concs = ' and '.join([str(rp) for rp in self.concs.all()])
        return '{} {} {}'.format(hyps, self.get_variety_display(), concs)

    def __repr__(self):
        return '<Logic: id={}>'.format(id(self))


class Theorem(models.Model):
    alias = models.CharField(max_length=100, null=True, blank=True)
    statement = models.TextField(max_length=400)
    citation = models.ManyToManyField('Citation', blank=True)
    link = models.URLField(blank=True, null=True)
    user = models.ForeignKey(User, blank=True, null=True)
    commutative_only = models.BooleanField(default=False)

    def __str__(self):
        if self.alias:
            return self.alias
        else:
            return textwrap.shorten(self.statement, width=1000)


class Ring(models.Model):
    name = models.CharField(max_length=250)
    description = models.TextField(max_length=1000)
    keywords = models.ManyToManyField('Keyword', blank=True)
    notes = models.CharField(max_length=500, blank=True, null=True)
    citation = models.ManyToManyField('Citation', blank=True)

    krull_dim = models.FloatField(blank=True, null=True)
    user = models.ForeignKey(User, blank=True, null=True)
    is_commutative = models.NullBooleanField()

    optional_template = models.CharField(max_length=128, blank=True, default='')

    class Meta:
        ordering = ('name',)

    def __str__(self):
        return self.name


class RingProperty(models.Model):
    ring = models.ForeignKey('Ring')
    property = models.ForeignKey('Property')
    has_on_left = models.NullBooleanField()
    reason_left = models.CharField(max_length=200, blank=True, null=True)
    citation_left = models.ManyToManyField('Citation', related_name='citation_left', blank=True)
    has_on_right = models.NullBooleanField()
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


class Metaproperty(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)

    class Meta:
        verbose_name_plural = 'Metaproperties'
        ordering = ('name',)

    def __str__(self):
        return self.name


class PropertyMetaproperty(models.Model):
    property = models.ForeignKey('Property')
    metaproperty = models.ForeignKey('Metaproperty')
    has_metaproperty = models.NullBooleanField()
    example = models.ForeignKey('Ring', blank=True, null=True)
    citation = models.ManyToManyField('Citation', blank=True)

    commutative_only = models.BooleanField(default=False)

    class Meta:
        verbose_name_plural = 'Property-metaproperty relationships'
        unique_together = (('property', 'metaproperty'), )

    def __str__(self):
        if self.has_metaproperty:
            return "%s : %s" % (self.property.name, self.metaproperty.definition)
        else:
            return "%s : not %s" % (self.property.name, self.metaproperty.definition)


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


class Suggestion(models.Model):
    object_type = models.SmallIntegerField(choices=[(0, 'ring'),
                                                    (1, 'citation'),
                                                    (2, 'theorem'),
                                                    (3, 'other'), ])
    status = models.SmallIntegerField(choices=[(-2, 'need info'),
                                               (-1, 'declined'),
                                               (0, 'pending'),
                                               (1, 'accepted'),
                                               (2, 'withdrawn')],
                                      default=0)
    name = models.CharField(max_length=50, null=True, blank=True)
    description = models.TextField(max_length=400, null=True, blank=True)
    response = models.TextField(max_length=200, null=True, blank=True)
    citation = models.CharField(max_length=200, null=True, blank=True)
    user = models.ForeignKey(User)

    def __str__(self):
        return textwrap.shorten('[{}] {} {}'.format(self.get_object_type_display(),
                                                    self.name, self.description), width=75)


class News(models.Model):
    title = models.CharField(max_length=64, null=True, blank=True)
    category = models.CharField(max_length=64, null=True, blank=True)
    content = models.TextField(max_length=400, null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = 'News items'

    def __str__(self):
        return textwrap.shorten('{} [{}] {}'.format(self.title, self.category, self.content), width=75)


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


# @receiver(pre_save, sender=RingProperty)
# def symmetrize(sender, instance, *args, **kwargs):
#     if instance.ring.is_commutative or instance.property.symmetric:
#         symmetrize_sides(instance)
