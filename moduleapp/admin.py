from django.contrib import admin
import django.db.models as dj_models
from django.contrib.admin.widgets import FilteredSelectMultiple
from moduleapp.models import (
    Logic,
    Metaproperty,
    Module,
    ModuleProperty,
    Property,
    PropertyMetaproperty,
    Citation
)


class PropertyMetapropertyInline(admin.TabularInline):
    model = PropertyMetaproperty
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example']
    extra = 1


class PropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', 'citation']
    inlines = [PropertyMetapropertyInline, ]
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class ModulePropertyAdmin(admin.ModelAdmin):
    model = ModuleProperty
    fields = [('module', 'property'),
              ('has', 'reason', 'citation'),]
    list_display = ['module', 'property', 'has', ]
    list_filter = ['module', 'property']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class ModuleAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'ring', 'opposite_ring', 'citation']
    list_display = ['name']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class LogicAdmin(admin.ModelAdmin):
    fields = ['hyps',
              'ring_hyps',
              'concs',
              'variety', 'citation', 'active']
    list_display = ['hypotheses', 'ringhypotheses', 'conclusions', 'variety', 'active']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }

    def hypotheses(self, obj):
        return ', '.join([str(x) for x in obj.hyps.all()])

    def conclusions(self, obj):
        return ', '.join([str(x) for x in obj.concs.all()])

    def ringhypotheses(self, obj):
        return ', '.join([str(x) for x in obj.ring_hyps.all()])

#
# class PropertyMetapropertyAdmin(admin.ModelAdmin):
#     fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'citation']
#     list_display = ['property', 'metaproperty', 'has_metaproperty']
#     list_filter = ['property', 'metaproperty']
#     formfield_overrides = {
#         dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
#     }
#
#


class MetapropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']


class CitationAdmin(admin.ModelAdmin):
    fields = ['publication', 'location']
    list_display = ['publication', 'location']
    list_filter = ['publication', ]
    ordering = ('publication__authors',)

admin.site.register(Module, ModuleAdmin)
admin.site.register(Property, PropertyAdmin)
admin.site.register(Logic, LogicAdmin)
admin.site.register(Metaproperty, MetapropertyAdmin)
admin.site.register(ModuleProperty, ModulePropertyAdmin)
admin.site.register(Citation, CitationAdmin)
