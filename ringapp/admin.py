from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User

from ringapp.SuggestionUtils import humanize_souffle
from ringapp.models import *
import django.db.models as dj_models
from django.contrib.admin.widgets import FilteredSelectMultiple


# Customizing the visible User fields in the admin
UserAdmin.list_display = ('username', 'email', 'date_joined', 'last_login', 'is_staff')
admin.site.unregister(User)
admin.site.register(User, UserAdmin)


class PropertyMetapropertyInline(admin.TabularInline):
    model = PropertyMetaproperty
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example']
    extra = 1


class PropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', ('symmetric', 'commutative_only', 'citation')]
    inlines = [PropertyMetapropertyInline, ]
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class KeywordAdmin(admin.ModelAdmin):
    fields = ['name', 'description']


class RingPropertyAdmin(admin.ModelAdmin):
    model = RingProperty
    fields = [('ring', 'property'),
              ('has_on_left', 'reason_left', 'citation_left'),
              ('has_on_right', 'reason_right', 'citation_right'), ]
    list_display = ['ring', 'property', 'has_on_left', 'has_on_right']
    list_filter = ['ring', 'property']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class RingPropertyInline(admin.TabularInline):
    model = RingProperty
    fields = [('ring', 'property'),
              ('has_on_left', 'reason_left', 'citation_left'),
              ('has_on_right', 'reason_right', 'citation_right'), ]
    extra = 1


class RingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'optional_template',
              ('citation', 'keywords'),  ('krull_dim', 'is_commutative')]
    list_display = ['name', 'is_commutative']
    list_filter = ['is_commutative']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class PropertySideAdmin(admin.ModelAdmin):
    fields = ['property', 'side']


class LogicAdmin(admin.ModelAdmin):
    fields = ['hyps',
              'concs',
              'variety', 'symmetric', 'citation', 'active']
    list_display = ['hypotheses', 'conclusions', 'variety', 'symmetric', 'active']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }

    def hypotheses(self, obj):
        hyps = list(map(humanize_souffle, obj.hyps.split(' AND ')))
        return ' AND '.join(hyps)

    def conclusions(self, obj):
        concs = list(map(humanize_souffle, obj.concs.split(' AND ')))
        return ' AND '.join(concs)


class TheoremAdmin(admin.ModelAdmin):
    fields = ['alias', 'statement', 'categories', 'citation', 'link', 'commutative_only']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class TheoremCategoryAdmin(admin.ModelAdmin):
    fields = ['name', 'description']


class CitationAdmin(admin.ModelAdmin):
    fields = ['publication', 'location']
    list_display = ['publication', 'location']
    list_filter = ['publication', ]
    ordering = ('publication__authors',)


class CitationInline(admin.TabularInline):
    model = Citation
    fields = ['publication', 'location']
    extra = 1


class ErrataAdmin(admin.ModelAdmin):
    mode = Erratum
    fields = ['error_location', 'description', 'corrected_location', 'example']


class PropertyMetapropertyAdmin(admin.ModelAdmin):
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'citation']
    list_display = ['property', 'metaproperty', 'has_metaproperty']
    list_filter = ['property', 'metaproperty']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class MetapropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']


class DimensionAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', 'symmetric']


class SubsetAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']


class RingDimensionAdmin(admin.ModelAdmin):
    fields = ['ring', 'dimension_type', 'left_dimension', 'reason_left', 'right_dimension', 'reason_right', 'citation']
    list_display = ['ring', 'dimension_type', 'left_dimension', 'right_dimension']
    list_filter = ['ring', 'dimension_type']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


class RingSubsetAdmin(admin.ModelAdmin):
    fields = ['ring', 'subset_type', 'subset', 'citation']
    list_display = ['ring', 'subset_type']
    list_filter = ['ring', 'subset_type']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }

#
# class FAQAdmin(admin.ModelAdmin):
#     fields = ['question', 'answer']
#
#
# class GlossaryAdmin(admin.ModelAdmin):
#     fields = ['term', 'definition', 'reference']


admin.site.register(Ring, RingAdmin)
admin.site.register(Property, PropertyAdmin)
admin.site.register(PropertySide, PropertySideAdmin)
admin.site.register(RingProperty, RingPropertyAdmin)
admin.site.register(Logic, LogicAdmin)
admin.site.register(Theorem, TheoremAdmin)
admin.site.register(TheoremCategory, TheoremCategoryAdmin)
admin.site.register(Citation, CitationAdmin)
admin.site.register(Erratum, ErrataAdmin)
admin.site.register(Keyword, KeywordAdmin)
admin.site.register(PropertyMetaproperty, PropertyMetapropertyAdmin)
admin.site.register(Metaproperty, MetapropertyAdmin)
admin.site.register(Dimension, DimensionAdmin)
admin.site.register(Subset, SubsetAdmin)
admin.site.register(RingDimension, RingDimensionAdmin)
admin.site.register(RingSubset, RingSubsetAdmin)
# admin.site.register(FAQ, FAQAdmin)
# admin.site.register(Glossary, GlossaryAdmin)
