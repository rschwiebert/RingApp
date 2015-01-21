from django.contrib import admin
from ringapp.models import Ring, Property, RingProperty, Equivalents, Logic, Invariance
from ringapp.models import CommProperty, CommRingProperty, CommEquivalents, CommLogic, CommInvariance
from ringapp.models import Theorem, Publication, Citation, Keyword, Metaproperty
from ringapp.models import FAQ, Glossary


class RingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'reference', 'kwds', 'keywords']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class PropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class KeywordAdmin(admin.ModelAdmin):
    fields = ['name']


class RingPropertyAdmin(admin.ModelAdmin):
    fields = ['ring', 'property', 'has_property', 'reason', 'source']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class EquivalentsAdmin(admin.ModelAdmin):
    fields = ['property', 'equivalent', 'source', 'keywords']


class CommPropertyAdmin(admin.ModelAdmin):
    fields = ['name', 'definition']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class CommRingPropertyAdmin(admin.ModelAdmin):
    fields = ['ring', 'property', 'has_property', 'reason', 'source']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class CommEquivalentsAdmin(admin.ModelAdmin):
    fields = ['property', 'equivalent', 'source', 'keywords']


class LogicAdmin(admin.ModelAdmin):
    fields = ['readable', 'citation', 'theorem']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class CommLogicAdmin(admin.ModelAdmin):
    fields = ['readable', 'citation', 'theorem']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class TheoremAdmin(admin.ModelAdmin):
    fields = ['alias', 'statement', 'reference', 'link', 'characterizs', 'comm_characterizes']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class CitationAdmin(admin.ModelAdmin):
    fields = ['publication', 'location']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


class PublicationAdmin(admin.ModelAdmin):
    fields = ['title', 'authors', 'details', 'pub_date']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.poster = request.user.username
        obj.save()


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


admin.site.register(Ring, RingAdmin)
admin.site.register(Property, PropertyAdmin)
admin.site.register(RingProperty, RingPropertyAdmin)
admin.site.register(Logic, LogicAdmin)
admin.site.register(CommLogic, CommLogicAdmin)
# admin.site.register(Equivalents, EquivalentsAdmin)
# admin.site.register(CommEquivalents, CommEquivalentsAdmin)
admin.site.register(CommProperty, CommPropertyAdmin)
admin.site.register(CommRingProperty, CommRingPropertyAdmin)
admin.site.register(Theorem, TheoremAdmin)
admin.site.register(Publication, PublicationAdmin)
admin.site.register(Citation, CitationAdmin)
admin.site.register(Keyword, KeywordAdmin)
admin.site.register(Invariance, InvarianceAdmin)
admin.site.register(CommInvariance, CommInvarianceAdmin)
admin.site.register(Metaproperty, MetapropertyAdmin)
admin.site.register(FAQ, FAQAdmin)
admin.site.register(Glossary, GlossaryAdmin)