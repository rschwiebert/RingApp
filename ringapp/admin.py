from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from ringapp.models import *
from ringapp.AdminUtils import rewriteName


# Customizing the visible User fields in the admin
UserAdmin.list_display = ('username', 'email', 'date_joined', 'last_login', 'is_staff')
admin.site.unregister(User)
admin.site.register(User, UserAdmin)


class InvarianceInline(admin.TabularInline):
    model = Invariance
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'theorem', 'note']
    extra = 1


class PropertyAdmin(admin.ModelAdmin):
    readonly_fields = ['property_id']
    fields = ['property_id', 'name', 'definition', 'comm_version']
    inlines = [InvarianceInline]


class KeywordAdmin(admin.ModelAdmin):
    fields = ['name', 'description']


class RingPropertyAdmin(admin.ModelAdmin):
    fields = ['ring', 'property', 'has_property', 'reason', 'source']


class RingPropertyInline(admin.TabularInline):
    model = RingProperty
    fields = ['ring', 'property', 'has_property', 'reason', 'source']
    extra = 1


class CommRingPropertyInline(admin.TabularInline):
    model = CommRingProperty
    fields = ['ring', 'property', 'has_property', 'reason', 'source']
    extra = 1


class RingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'reference', 'old_reference', 'keywords', 'kwds', 'user']
    readonly_fields = ('kwds', 'old_reference')
    inlines = [
        RingPropertyInline,
    ]


class CommRingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'reference', 'kwds', 'keywords', 'user']
    inlines = [
        CommRingPropertyInline,
    ]

    def get_queryset(self, request):
        prop = Property.objects.get(name='commutative')
        rids = [ring.ring_id for ring in RingProperty.objects.filter(property=prop)]
        return Ring.objects.filter(ring_id__in=rids)


class EquivalentsAdmin(admin.ModelAdmin):
    fields = ['property', 'equivalent', 'source', 'keywords']


class CommInvarianceInline(admin.TabularInline):
    model = CommInvariance
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'theorem', 'note']
    extra = 1


class CommPropertyAdmin(admin.ModelAdmin):
    readonly_fields = ['property_id']
    fields = ['property_id', 'name', 'definition']
    inlines = [CommInvarianceInline]


class CommRingPropertyAdmin(admin.ModelAdmin):
    fields = ['ring', 'property', 'has_property', 'reason', 'source']


class CommEquivalentsAdmin(admin.ModelAdmin):
    fields = ['property', 'equivalent', 'source', 'keywords']


class LogicAdmin(admin.ModelAdmin):
    fields = ['cond_1', 'cond_2', 'cond_3', 'cond_4', 'conc', 'readable', 'citation', 'theorem']

    def save_model(self, request, obj, form, change):
        if not change:
            conds = [obj.cond_1, obj.cond_2, obj.cond_3, obj.cond_4]
            conds = filter(lambda x: x is not None, conds)
            conc = obj.conc
            readable_conds = [Property.objects.get(pk=i).name for i in conds]
            readable_conds = map(rewriteName, readable_conds)
            readable_conc = rewriteName(Property.objects.get(pk=conc).name)
            output = " and ".join(readable_conds) + " implies %s" % readable_conc
            obj.readable = output
        obj.save()


class CommLogicAdmin(admin.ModelAdmin):
    fields = ['cond_1', 'cond_2', 'cond_3', 'cond_4', 'conc', 'readable', 'citation', 'theorem']


class TheoremAdmin(admin.ModelAdmin):
    fields = ['alias', 'statement', 'reference', 'link', 'characterizes', 'comm_characterizes']


class CitationAdmin(admin.ModelAdmin):
    fields = ['publication', 'location']
    ordering = ('publication',)


class CitationInline(admin.TabularInline):
    model = Citation
    fields = ['publication', 'location']
    extra = 1


class PublicationAdmin(admin.ModelAdmin):
    fields = ['title', 'authors', 'details', 'pub_date']
    ordering = ('authors',)
    inlines = [CitationInline]


class SuggestionAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'object_type', 'status', 'response', 'user']
    

class InvarianceAdmin(admin.ModelAdmin):
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'theorem', 'note']


class CommInvarianceAdmin(admin.ModelAdmin):
    fields = ['property', 'metaproperty', 'has_metaproperty', 'example', 'theorem', 'note']


class MetapropertyAdmin(admin.ModelAdmin):
    fields = ['description']


class FAQAdmin(admin.ModelAdmin):
    fields = ['question', 'answer']


class GlossaryAdmin(admin.ModelAdmin):
    fields = ['term', 'definition', 'reference']


class NewsAdmin(admin.ModelAdmin):
    fields = ['title', 'category', 'content']


admin.site.register(Ring, RingAdmin)
admin.site.register(CommRing, CommRingAdmin)
admin.site.register(Property, PropertyAdmin)
# admin.site.register(RingProperty, RingPropertyAdmin)
admin.site.register(Logic, LogicAdmin)
admin.site.register(CommLogic, CommLogicAdmin)
# admin.site.register(Equivalents, EquivalentsAdmin)
# admin.site.register(CommEquivalents, CommEquivalentsAdmin)
admin.site.register(CommProperty, CommPropertyAdmin)
# admin.site.register(CommRingProperty, CommRingPropertyAdmin)
admin.site.register(Theorem, TheoremAdmin)
admin.site.register(Publication, PublicationAdmin)
admin.site.register(Citation, CitationAdmin)
admin.site.register(Keyword, KeywordAdmin)
admin.site.register(Invariance, InvarianceAdmin)
admin.site.register(CommInvariance, CommInvarianceAdmin)
admin.site.register(Metaproperty, MetapropertyAdmin)
admin.site.register(FAQ, FAQAdmin)
admin.site.register(Glossary, GlossaryAdmin)
admin.site.register(Suggestion, SuggestionAdmin)
admin.site.register(News, NewsAdmin)
