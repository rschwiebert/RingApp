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
    Citation,
    Relation
)
from ringapp.SuggestionUtils import humanize_souffle


class PropertyMetapropertyInline(admin.TabularInline):
    model = PropertyMetaproperty
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example']
    extra = 1


@admin.register(Property)
class PropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', 'citation']
    inlines = [PropertyMetapropertyInline, ]
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(ModuleProperty)
class ModulePropertyAdmin(admin.ModelAdmin):
    model = ModuleProperty
    fields = [('module', 'property'),
              ('has', 'reason', 'citation'), ]
    list_display = ['module', 'property', 'has', ]
    list_filter = ['module', 'property']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(Module)
class ModuleAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'ring', 'opposite_ring', 'citation']
    list_display = ['name']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(Logic)
class LogicAdmin(admin.ModelAdmin):
    fields = ['hyps',
              'concs',
              'variety', 'citation', 'active']
    list_display = ['hypotheses', 'conclusions', 'variety', 'active']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }

    @staticmethod
    def hypotheses(obj):
        return ' AND '.join(list(map(humanize_souffle, obj.hyps.split(' AND '))))

    @staticmethod
    def conclusions(obj):
        return ' AND '.join(list(map(humanize_souffle, obj.concs.split(' AND '))))


@admin.register(PropertyMetaproperty)
class PropertyMetapropertyAdmin(admin.ModelAdmin):
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'relation', 'citation']
    list_display = ['property', 'metaproperty', 'has_metaproperty']
    list_filter = ['property', 'metaproperty']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(Metaproperty)
class MetapropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', 'relation_type']


@admin.register(Citation)
class CitationAdmin(admin.ModelAdmin):
    fields = ['publication', 'location']
    list_display = ['publication', 'location']
    list_filter = ['publication', ]
    ordering = ('publication__authors',)


@admin.register(Relation)
class RelationAdmin(admin.ModelAdmin):
    fields = ['first', 'relation_type', 'second', 'note']
    list_display = ['first', 'relation_type', 'second']


