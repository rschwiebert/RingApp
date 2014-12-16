from django.contrib import admin
from ringapp.models import Ring, Property, RingProperty, Equivalents
from ringapp.models import CommProperty, CommRingProperty, CommEquivalents

class RingAdmin(admin.ModelAdmin):
    fields = ['name','description','notes','reference','keywords']

class PropertyAdmin(admin.ModelAdmin):
    fields = ['name','definition']

class RingPropertyAdmin(admin.ModelAdmin):
    fields = ['ring','property','has_property','reason','source']

class EquivalentsAdmin(admin.ModelAdmin):
    fields = ['property','equivalent','source','keywords']

class CommPropertyAdmin(admin.ModelAdmin):
    fields = ['name','definition']

class CommRingPropertyAdmin(admin.ModelAdmin):
    fields = ['ring','property','has_property','reason','source']

class CommEquivalentsAdmin(admin.ModelAdmin):
    fields = ['property','equivalent','source','keywords']
    
# class LogicAdmin(admin.ModelAdmin):
    # fields = ['logic_ID','name','description','notes','reference','keywords']

    
admin.site.register(Ring,RingAdmin)
admin.site.register(Property,PropertyAdmin)
admin.site.register(RingProperty,RingPropertyAdmin)
#admin.site.register(Logic)
admin.site.register(Equivalents,EquivalentsAdmin)

admin.site.register(CommEquivalents,CommEquivalentsAdmin)
admin.site.register(CommProperty,CommPropertyAdmin)
admin.site.register(CommRingProperty,CommRingPropertyAdmin)