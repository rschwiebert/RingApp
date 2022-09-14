from django.shortcuts import render
from django.contrib.messages.views import SuccessMessageMixin
from django.views.generic.edit import CreateView
from ratelimit.mixins import RatelimitMixin
from ratelimit import UNSAFE


from web.models import Suggestion


class SuggestionView(RatelimitMixin, SuccessMessageMixin, CreateView):
    model = Suggestion
    template_name = 'dart_data/contribute.html'
    success_url = '/contribute/'
    fields = ['object_type', 'name', 'description']
    success_message = "Thanks... we'll look into that %(object_display)s suggestion!"
    ratelimit_key = 'user'
    ratelimit_rate = '20/h'
    ratelimit_method = UNSAFE
    ratelimit_block = True

    def form_valid(self, form):
        form.instance.user = self.request.user
        return super(SuggestionView, self).form_valid(form)

    def get_success_message(self, cleaned_data):
        return self.success_message % dict(
            cleaned_data,
            object_display=self.object.get_object_type_display(),
        )
