from django import forms
from ringapp.models import Property, CommProperty

prop_choices = [(0,'')] + [(obj.property_id ,obj.name ) for obj in Property.objects.all().order_by('name')] 
cprop_choices = [(0,'')] + [(obj.property_id ,obj.name ) for obj in CommProperty.objects.all().order_by('name')] 
scope_choices = [('n','Narrow'),('w','Wide')]

class SearchForm(forms.Form):
    scope = forms.ChoiceField(choices=scope_choices)
    has1 = forms.ChoiceField(choices=prop_choices)
    has2 = forms.ChoiceField(choices=prop_choices)
    has3 = forms.ChoiceField(choices=prop_choices)
    lacks1 = forms.ChoiceField(choices=prop_choices)
    lacks2 = forms.ChoiceField(choices=prop_choices)
    lacks3 = forms.ChoiceField(choices=prop_choices)
    
class CommSearchForm(forms.Form):
    scope = forms.ChoiceField(choices=scope_choices)
    has1 = forms.ChoiceField(choices=cprop_choices)
    has2 = forms.ChoiceField(choices=cprop_choices)
    has3 = forms.ChoiceField(choices=cprop_choices)
    lacks1 = forms.ChoiceField(choices=cprop_choices)
    lacks2 = forms.ChoiceField(choices=cprop_choices)
    lacks3 = forms.ChoiceField(choices=cprop_choices)
