from django import forms
from ringapp.models import Property, CommProperty, Ring

scope_choices = [('n', 'Narrow'), ('w', 'Wide')]


class SearchForm(forms.Form):
    scope = forms.ChoiceField(choices=scope_choices)
    has1 = forms.ModelChoiceField(queryset=Property.objects.all().order_by('name'))
    has2 = forms.ModelChoiceField(queryset=Property.objects.all().order_by('name'))
    has3 = forms.ModelChoiceField(queryset=Property.objects.all().order_by('name'))
    lacks1 = forms.ModelChoiceField(queryset=Property.objects.all().order_by('name'))
    lacks2 = forms.ModelChoiceField(queryset=Property.objects.all().order_by('name'))
    lacks3 = forms.ModelChoiceField(queryset=Property.objects.all().order_by('name'))


class CommSearchForm(forms.Form):
    scope = forms.ChoiceField(choices=scope_choices)
    has1 = forms.ModelChoiceField(queryset=CommProperty.objects.all().order_by('name'))
    has2 = forms.ModelChoiceField(queryset=CommProperty.objects.all().order_by('name'))
    has3 = forms.ModelChoiceField(queryset=CommProperty.objects.all().order_by('name'))
    lacks1 = forms.ModelChoiceField(queryset=CommProperty.objects.all().order_by('name'))
    lacks2 = forms.ModelChoiceField(queryset=CommProperty.objects.all().order_by('name'))
    lacks3 = forms.ModelChoiceField(queryset=CommProperty.objects.all().order_by('name'))


class ContribSelector(forms.Form):
    option = forms.ChoiceField(choices=[('ring', 'I want to suggest a ring.'),
                                        ('theorem', 'I want to suggest a theorem.'),
                                        ('citation', 'I want to suggest a citation.'),
                                        ('randring', 'Give me an idea for a ring!'),
                                        ('randcite', 'Give me an idea for a citation!'),
                                        ('property', 'I want to suggest a property.')])


class RingSelector(forms.Form):
    ring = forms.ModelChoiceField(queryset=Ring.objects.all().order_by('name'))