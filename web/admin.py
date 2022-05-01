from django.contrib import admin
from web.models import Suggestion


class SuggestionAdmin(admin.ModelAdmin):
    list_display = ['status', 'object_type', 'name', 'description', 'user']
    fields = ['name', 'description', 'object_type', 'status', 'response', 'unread', 'user']
    list_filter = ['status', 'object_type', 'user']


admin.site.register(Suggestion, SuggestionAdmin)
