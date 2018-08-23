from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from ringapp.models import *


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


class KeywordAdmin(admin.ModelAdmin):
    fields = ['name', 'description']


class RingPropertyAdmin(admin.ModelAdmin):
    model = RingProperty
    fields = [('ring', 'property'),
              ('has_on_left', 'reason_left', 'citation_left'),
              ('has_on_right', 'reason_right', 'citation_right'), ]
    list_display = ['ring', 'property', 'has_on_left', 'has_on_right']
    list_filter = ['ring', 'property']


class RingPropertyInline(admin.TabularInline):
    model = RingProperty
    fields = [('ring', 'property'),
              ('has_on_left', 'reason_left', 'citation_left'),
              ('has_on_right', 'reason_right', 'citation_right'), ]
    extra = 1


class RingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'optional_template',
              ('citation', 'keywords'),  ('krull_dim', 'is_commutative', 'user')]
    list_display = ['name', 'is_commutative', 'user']
    list_filter = ['is_commutative', 'user']
    # inlines = [
    #     RingPropertyInline,
    # ]


class PropertySideAdmin(admin.ModelAdmin):
    fields = ['property', 'side']


class LogicAdmin(admin.ModelAdmin):
    fields = ['hyps',
              'concs',
              'variety', 'symmetric', 'citation', 'user', 'active']
    list_display = ['hypotheses', 'conclusions', 'variety', 'symmetric', 'active']

    def hypotheses(self, obj):
        return ', '.join([str(x) for x in obj.hyps.all()])

    def conclusions(self, obj):
        return ', '.join([str(x) for x in obj.concs.all()])


class TheoremAdmin(admin.ModelAdmin):
    fields = ['alias', 'statement', 'citation', 'link', 'commutative_only', 'user']


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


class SuggestionAdmin(admin.ModelAdmin):
    list_display = ['status', 'object_type', 'name', 'description', 'user']
    fields = ['name', 'description', 'object_type', 'status', 'response', 'unread', 'user']
    list_filter = ['status', 'object_type', 'user']
    

class PropertyMetapropertyAdmin(admin.ModelAdmin):
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'citation']
    list_display = ['property', 'metaproperty', 'has_metaproperty']
    list_filter = ['property', 'metaproperty']


class MetapropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']


class DimensionAdmin(admin.ModelAdmin):
    fields = ['name', 'definition', 'symmetric']


class SubsetAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']


class RingDimensionAdmin(admin.ModelAdmin):
    fields = ['ring', 'dimension_type', 'left_dimension', 'right_dimension', 'citation']
    list_display = ['ring', 'dimension_type', 'left_dimension', 'right_dimension']
    list_filter = ['ring', 'dimension_type']


class RingSubsetAdmin(admin.ModelAdmin):
    fields = ['ring', 'subset_type', 'subset', 'citation']
    list_display = ['ring', 'subset_type']
    list_filter = ['ring', 'subset_type']

#
# class FAQAdmin(admin.ModelAdmin):
#     fields = ['question', 'answer']
#
#
# class GlossaryAdmin(admin.ModelAdmin):
#     fields = ['term', 'definition', 'reference']


class NewsAdmin(admin.ModelAdmin):
    fields = ['title', 'category', 'content']


admin.site.register(Ring, RingAdmin)
admin.site.register(Property, PropertyAdmin)
admin.site.register(PropertySide, PropertySideAdmin)
admin.site.register(RingProperty, RingPropertyAdmin)
admin.site.register(Logic, LogicAdmin)
admin.site.register(Theorem, TheoremAdmin)
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
admin.site.register(Suggestion, SuggestionAdmin)
admin.site.register(News, NewsAdmin)
