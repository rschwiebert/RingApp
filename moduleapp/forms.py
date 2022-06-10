import re

from django.forms import formset_factory
from django import forms

from moduleapp.models import Property

TERM_PAT = re.compile(r'([0-9]+)(l|r)?')

NEGATOR_CHOICES = [('H', 'is'), ('L', 'is not')]


def term_to_readable(term):
    """
    Translate a search term  to a readable phrase
    :param term: string matching <id>(l|r)?
    :return: (property.name, side) where side is readable
    """
    pk, side = TERM_PAT.match(term).groups()
    pk = int(pk)
    try:
        property = Property.objects.get(id=pk)
    except Property.DoesNotExist:
        return 'No property matching id {}!'.format(pk)

    return property.name


class SearchForm(forms.Form):
    negator = forms.ChoiceField(choices=NEGATOR_CHOICES)
    property = forms.ModelChoiceField(queryset=Property.objects.all())

    def is_valid(self):
        if self.cleaned_data.get('property'):
            return super().is_valid()
        return False

    def human_readable(self):
        """
        :return: Human readable version of the search term
        Needs to be called after .full_clean()
        """
        if not self.cleaned_data:
            return 'Run full clean on {}'.format(self)
        neg = dict(NEGATOR_CHOICES)[self.cleaned_data['negator']]
        return '{} {}'.format(neg, self.property.name)

    def get_getparam(self):
        """
        This is what needs to go into the GET parameters for the results
        Needs to be called after .full_clean()
        :return: <id>
        """
        if not self.cleaned_data:
            return 'Run full clean on {}'.format(self)
        return '{}'.format(self.cleaned_data['property'].id)


SearchFormSet = formset_factory(SearchForm, extra=2, max_num=5)
