import re
from captcha.fields import ReCaptchaField
from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.forms.models import formset_factory
from ringapp.models import Property, Ring, Keyword


SIDE_CHOICES = [
    ('l', 'on the left'),
    ('r', 'on the right'),
]

NEGATOR_CHOICES = [('H', 'is'), ('L', 'is not')]
TERM_PAT = re.compile(r'([0-9]+)(l|r)?')


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
    if side:
        side = dict(SIDE_CHOICES)[side]
    else:
        side = ''
    return property.name, side


class AsymmSearchForm(forms.Form):
    negator = forms.ChoiceField(choices=NEGATOR_CHOICES)
    property = forms.ModelChoiceField(queryset=Property.objects.exclude(commutative_only=True)
                                      .filter(symmetric=False))
    side = forms.ChoiceField(choices=SIDE_CHOICES)

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
        side = dict(SIDE_CHOICES)[self.cleaned_data['side']]
        return '{} {} {}'.format(neg, self.property.name, side)

    def get_getparam(self):
        """
        This is what needs to go into the GET parameters for the results
        Needs to be called after .full_clean()
        :return: <id>(l|r)
        """
        if not self.cleaned_data:
            return 'Run full clean on {}'.format(self)
        return '{}{}'.format(self.cleaned_data['property'].id,
                             self.cleaned_data['side'])


class SymmSearchForm(forms.Form):
    negator = forms.ChoiceField(choices=NEGATOR_CHOICES)
    property = forms.ModelChoiceField(queryset=Property.objects.exclude(commutative_only=True)
                                      .filter(symmetric=True))

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


class CommSearchForm(forms.Form):
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
        return '{} {}'.format(neg, self.cleaned_data['property'].name)

    def get_getparam(self):
        """
        This is what needs to go into the GET parameters for the results
        Needs to be called after .full_clean()
        :return: <id>
        """
        if not self.cleaned_data:
            return 'Run full clean on {}'.format(self)
        ret_val = '{}'.format(self.cleaned_data['property'].id)
        if not self.cleaned_data['property'].symmetric:
            ret_val += 'l'  # Need sided parameter, so we just default to left
        return ret_val


AsymmSearchFormSet = formset_factory(AsymmSearchForm, extra=2, max_num=5)
SymmSearchFormSet = formset_factory(SymmSearchForm, extra=2, max_num=5)
CommSearchFormSet = formset_factory(CommSearchForm, extra=2, max_num=5)


class RingSelector(forms.Form):
    ring = forms.ModelChoiceField(queryset=Ring.objects.all().order_by('name'))


class KeywordSearchForm(forms.Form):
    kwd = forms.ModelChoiceField(queryset=Keyword.objects.all().order_by('name'), 
                                 widget=forms.SelectMultiple(attrs={'size': '15'}),
                                 empty_label=None)


class RatelimitedAuthenticationForm(AuthenticationForm):
    captcha = ReCaptchaField()
