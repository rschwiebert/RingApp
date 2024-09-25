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


@admin.register(Property)
class PropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', ('symmetric', 'commutative_only', 'citation')]
    inlines = [PropertyMetapropertyInline, ]
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(Keyword)
class KeywordAdmin(admin.ModelAdmin):
    fields = ['name', 'description']


@admin.register(RingProperty)
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


@admin.register(Ring)
class RingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'optional_template',
              ('citation', 'keywords'),  ('krull_dim', 'is_commutative')]
    list_display = ['name', 'is_commutative']
    list_filter = ['is_commutative']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(PropertySide)
class PropertySideAdmin(admin.ModelAdmin):
    fields = ['property', 'side']


@admin.register(Logic)
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


@admin.register(Theorem)
class TheoremAdmin(admin.ModelAdmin):
    fields = ['alias', 'statement', 'categories', 'citation', 'link', 'commutative_only']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(TheoremCategory)
class TheoremCategoryAdmin(admin.ModelAdmin):
    fields = ['name', 'description']


@admin.register(Citation)
class CitationAdmin(admin.ModelAdmin):
    fields = ['publication', 'location']
    list_display = ['publication', 'location']
    list_filter = ['publication', ]
    ordering = ('publication__authors',)


class CitationInline(admin.TabularInline):
    model = Citation
    fields = ['publication', 'location']
    extra = 1


@admin.register(Erratum)
class ErrataAdmin(admin.ModelAdmin):
    mode = Erratum
    fields = ['error_location', 'description', 'corrected_location', 'example']


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


@admin.register(Dimension)
class DimensionAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', 'symmetric']


@admin.register(Subset)
class SubsetAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']


@admin.register(RingDimension)
class RingDimensionAdmin(admin.ModelAdmin):
    fields = ['ring', 'dimension_type', 'left_dimension', 'reason_left', 'right_dimension', 'reason_right', 'citation']
    list_display = ['ring', 'dimension_type', 'left_dimension', 'right_dimension']
    list_filter = ['ring', 'dimension_type']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(RingSubset)
class RingSubsetAdmin(admin.ModelAdmin):
    fields = ['ring', 'subset_type', 'subset', 'citation']
    list_display = ['ring', 'subset_type']
    list_filter = ['ring', 'subset_type']
    formfield_overrides = {
        dj_models.ManyToManyField: {'widget': FilteredSelectMultiple('citations', False)}
    }


@admin.register(Relation)
class RelationAdmin(admin.ModelAdmin):
    fields = ['first', 'relation_type', 'second', 'note']
    list_display = ['first', 'relation_type', 'second']

#
# class FAQAdmin(admin.ModelAdmin):
#     fields = ['question', 'answer']
#
#
# class GlossaryAdmin(admin.ModelAdmin):
#     fields = ['term', 'definition', 'reference']



