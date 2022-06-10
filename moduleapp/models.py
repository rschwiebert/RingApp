from django.db import models


class Module(models.Model):
    name = models.CharField(max_length=250)
    description = models.TextField(max_length=1000)
    notes = models.CharField(max_length=500, blank=True, null=True)
    citation = models.ManyToManyField('Citation', blank=True)
    ring = models.ForeignKey('ringapp.Ring', on_delete=models.CASCADE)
    opposite_ring = models.BooleanField(default=False,
                                        help_text='When true, use the opposite ring of the associated ring.')

    class Meta:
        ordering = ('name',)

    def __str__(self):
        return self.name


class Property(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)
    citation = models.ManyToManyField('Citation', blank=True)

    class Meta:
        verbose_name_plural = 'Properties'
        ordering = ('name',)

    def __str__(self):
        return self.name


class ModuleProperty(models.Model):
    module = models.ForeignKey('moduleapp.Module', on_delete=models.CASCADE)
    property = models.ForeignKey('moduleapp.Property', on_delete=models.CASCADE)
    has = models.BooleanField(null=True)
    reason = models.CharField(max_length=200, blank=True, null=True)
    citation = models.ManyToManyField('moduleapp.Citation', related_name='citation', blank=True)

    class Meta:
        verbose_name_plural = 'Module-property relationships'
        unique_together = (('module', 'property'),)

    def __str__(self):
        return f'{self.module} {"has" if self.has else "does not have"} property {self.property}'


class Logic(models.Model):
    hyps = models.ManyToManyField('moduleapp.Property', related_name='hypotheses', verbose_name="hypotheses")
    ring_hyps = models.ManyToManyField('ringapp.PropertySide',
                                       blank=True,
                                       related_name='ring_hypotheses',
                                       verbose_name="ring_hypotheses")
    concs = models.ManyToManyField('moduleapp.Property', related_name='conclusions', verbose_name="conclusions")
    variety = models.PositiveSmallIntegerField(choices=[(0, '===>'), (1, '<==>')], null=True)
    citation = models.ManyToManyField('Citation', blank=True)

    active = models.BooleanField(default=True)

    def __str__(self):
        hyps = ' and '.join([str(rp) for rp in self.hyps.all()])
        ring_hyps = ' and '.join([str(rp) for rp in self.ring_hyps.all()])
        concs = ' and '.join([str(rp) for rp in self.concs.all()])
        return f'Module {hyps}{f" and ring {ring_hyps}" if ring_hyps else ""} {self.get_variety_display()} {concs}'

    def __repr__(self):
        return '<moduleapp.Logic: id={}>'.format(id(self))


class PropertyMetaproperty(models.Model):
    property = models.ForeignKey('moduleapp.Property', on_delete=models.CASCADE)
    metaproperty = models.ForeignKey('moduleapp.Metaproperty', on_delete=models.CASCADE)
    has_metaproperty = models.BooleanField(null=True)
    example = models.ForeignKey('Module', blank=True, null=True, on_delete=models.CASCADE)
    citation = models.ManyToManyField('moduleapp.Citation', blank=True)

    class Meta:
        verbose_name_plural = 'Property-metaproperty relationships'
        unique_together = (('property', 'metaproperty'), )

    def __str__(self):
        if self.has_metaproperty:
            return "%s : %s" % (self.property.name, self.metaproperty.name)
        else:
            return "%s : not %s" % (self.property.name, self.metaproperty.name)


class Citation(models.Model):
    publication = models.ForeignKey('ringapp.Publication', related_name='module_publication', on_delete=models.CASCADE)
    location = models.CharField(max_length=128)

    class Meta:
        ordering = ('publication__authors', 'publication__title')

    def __str__(self):
        return '{} @ {}'.format(self.publication, self.location)


class Metaproperty(models.Model):
    name = models.CharField(max_length=128)
    definition = models.TextField(max_length=1024)

    class Meta:
        verbose_name_plural = 'Metaproperties'
        ordering = ('name',)

    def __str__(self):
        return self.name
