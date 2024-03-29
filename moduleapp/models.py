from typing import List

from django.db import models, transaction
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _

from datalog.souffle_utils import logic_to_rulelist


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
    hyps = models.CharField(max_length=255, null=True, blank=False)
    concs = models.CharField(max_length=255, null=True, blank=False)
    variety = models.PositiveSmallIntegerField(choices=[(0, '===>'), (1, '<==>')], null=True)
    citation = models.ManyToManyField('Citation', blank=True)

    active = models.BooleanField(default=True)

    def __str__(self):
        return f'Module {self.hyps} {self.get_variety_display()} {self.concs}'

    def __repr__(self):
        return '<moduleapp.Logic: id={}>'.format(id(self))

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

        ruleset.discard('')
        rulelist = list(sorted(map(lambda x: x + f'  // logic {self.id}', ruleset)))
        return rulelist


class PropertyMetaproperty(models.Model):
    property = models.ForeignKey('moduleapp.Property', on_delete=models.CASCADE)
    metaproperty = models.ForeignKey('moduleapp.Metaproperty', on_delete=models.CASCADE)
    has_metaproperty = models.BooleanField(null=True)
    example = models.ForeignKey('Module', blank=True, null=True, on_delete=models.CASCADE)
    relation = models.ForeignKey('Relation', blank=True, null=True, on_delete=models.CASCADE)
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


class Relation(models.Model):
    class Meta:
        unique_together = (('first', 'second', 'relation_type'),)

    class RelationType(models.TextChoices):
        NONE = 'NONE', _('(error)')
        SUB_OF = 'SUBMOD_OF', _('is a submodule of'),
        IM_OF = 'IMAGE_OF', _('is a homomorphic image of'),
        SUMMAND_OF = 'SUMMAND_OF', _('is a direct summand of'),

    first = models.ForeignKey(Module, related_name='first_module', on_delete=models.CASCADE)
    relation_type = models.CharField(max_length=32, choices=RelationType.choices)
    second = models.ForeignKey(Module, related_name='second_module', on_delete=models.CASCADE)
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


@receiver(post_save, sender=Relation)
def propagate_relation(sender, instance, *args, **kwargs):
    if instance.relation_type == Relation.RelationType.NONE:
        return
    mp = Metaproperty.objects.filter(relation_type=instance.relation_type).first()
    if mp is None:
        return

    props = {x.property for x in instance.first.moduleproperty_set.filter(has=False)} & {
        x.property for x in instance.second.moduleproperty_set.filter(has=True)}

    with transaction.atomic():
        count = 0
        for prop in props:
            pmp, _ = PropertyMetaproperty.objects.get_or_create(property=prop, metaproperty=mp)

            if pmp.has_metaproperty is True:
                raise Exception(f"Contradiction of PropertyMetaproperty data {pmp} with relation {instance}")
            pmp.has_metaproperty = False
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
