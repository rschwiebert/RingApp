from django.contrib import admin
from ringapp.models import Ring, Property, RingProperty, Equivalents, Logic
from ringapp.models import CommProperty, CommRingProperty, CommEquivalents, CommLogic
from ringapp.models import Theorem, Publication, Citation


class RingAdmin(admin.ModelAdmin):
    fields = ['name', 'description', 'notes', 'reference', 'keywords']

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


# class LogicAdmin(admin.ModelAdmin):
#     fields = ['description', 'notes', 'reference', 'keywords']
#
#     def save_model(self, request, obj, form, change):
#         if not change:
#             obj.poster = request.user.username
#         obj.save()


# class CommLogicAdmin(admin.ModelAdmin):
#     fields = ['logic_ID', 'name', 'description', 'notes', 'reference', 'keywords']
#
#     def save_model(self, request, obj, form, change):
#         if not change:
#             obj.poster = request.user.username
#         obj.save()


class TheoremAdmin(admin.ModelAdmin):
    fields = ['alias', 'statement', 'reference', 'link']

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
    
admin.site.register(Ring, RingAdmin)
admin.site.register(Property, PropertyAdmin)
admin.site.register(RingProperty, RingPropertyAdmin)
# admin.site.register(Logic, LogicAdmin)
# admin.site.register(CommLogic, CommLogicAdmin)
admin.site.register(Equivalents, EquivalentsAdmin)
admin.site.register(CommEquivalents, CommEquivalentsAdmin)
admin.site.register(CommProperty, CommPropertyAdmin)
admin.site.register(CommRingProperty, CommRingPropertyAdmin)
admin.site.register(Theorem, TheoremAdmin)
admin.site.register(Publication, PublicationAdmin)
admin.site.register(Citation, CitationAdmin)
