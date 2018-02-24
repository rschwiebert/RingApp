from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
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
    fields = ['name', 'definition', ('symmetric', 'commutative_only', 'user')]
    inlines = [PropertyMetapropertyInline, ]


class KeywordAdmin(admin.ModelAdmin):
    fields = ['name', 'description']


class RingPropertyAdmin(admin.ModelAdmin):
    model = RingProperty
    fields = [('ring', 'property'),
              ('has_on_left', 'reason_left', 'citation_left'),
              ('has_on_right', 'reason_right', 'citation_right'), ]


class RingPropertyInline(admin.TabularInline):
    model = RingProperty
    fields = [('ring', 'property'),
              ('has_on_left', 'reason_left', 'citation_left'),
              ('has_on_right', 'reason_right', 'citation_right'), ]
    extra = 1


class RingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'optional_template',
              ('citation', 'keywords'),  ('krull_dim', 'is_commutative', 'user')]
    # inlines = [
    #     RingPropertyInline,
    # ]


class PropertySideAdmin(admin.ModelAdmin):
    fields = ['property', 'side']


class LogicAdmin(admin.ModelAdmin):
    model = Logic
    fields = ['hyps',
              'concs',
              'variety', 'symmetric', 'citation', 'user', 'active']


class TheoremAdmin(admin.ModelAdmin):
    fields = ['alias', 'statement', 'citation', 'link', 'commutative_only', 'user']


class CitationAdmin(admin.ModelAdmin):
    fields = ['publication', 'location']
    ordering = ('publication__authors',)


class CitationInline(admin.TabularInline):
    model = Citation
    fields = ['publication', 'location']
    extra = 1


class SuggestionAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'object_type', 'status', 'response', 'unread', 'user']
    

class PropertyMetapropertyAdmin(admin.ModelAdmin):
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'citation']


class MetapropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']

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
admin.site.register(Keyword, KeywordAdmin)
admin.site.register(PropertyMetaproperty, PropertyMetapropertyAdmin)
admin.site.register(Metaproperty, MetapropertyAdmin)
# admin.site.register(FAQ, FAQAdmin)
# admin.site.register(Glossary, GlossaryAdmin)
admin.site.register(Suggestion, SuggestionAdmin)
admin.site.register(News, NewsAdmin)
