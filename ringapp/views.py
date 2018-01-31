import random
import time
from math import isinf
import logging

from django.contrib.auth.views import LoginView
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.core.urlresolvers import reverse
from django.http import HttpResponse, QueryDict, HttpResponseNotAllowed
from django.shortcuts import render, redirect
from django.utils.translation import ugettext_lazy as _
from django.views.decorators.http import require_GET, require_http_methods
from django.views.generic import DetailView, ListView, TemplateView, RedirectView
from django.views.generic.edit import CreateView

from ratelimit import UNSAFE
from ratelimit.decorators import ratelimit
from ratelimit.exceptions import Ratelimited
from ratelimit.mixins import RatelimitMixin
from ratelimit.utils import is_ratelimited

from ringapp.models import Ring, Property, PropertyMetaproperty
from ringapp.models import Theorem, Suggestion, Keyword, News, Publication
from ringapp import forms
from ringapp.constants import PROPSV1_TO_TERMSV2, PROPSV1COMM_TO_TERMSV2

from ringapp.SearchUtils import (mirror_search_terms,
                                 detect_asymmetric_search,
                                 ring_search, LogicEngine,
                                 completeness_scores)

vlogger = logging.getLogger(__name__)


class IndexView(TemplateView):
    template_name = 'ringapp/index.html'
    http_method_names = ['get', ]

    def get_context_data(self, **kwargs):
        context = super(IndexView, self).get_context_data(**kwargs)
        context['newsitems'] = News.objects.all().order_by('-id')[:10]
        return context


@require_http_methods(['GET', 'POST'])
def searchpage(request):
    if request.method == 'POST':
        asymm_formset = forms.AsymmSearchFormSet(request.POST, request.FILES, prefix='asymm')
        symm_formset = forms.SymmSearchFormSet(request.POST, request.FILES, prefix='symm')

        qdict = QueryDict('', mutable=True)
        getkeylists = {'H': [], 'L': []}
        for form in asymm_formset.forms + symm_formset.forms:
            form.full_clean()
            if form.is_valid():
                getkey = form.cleaned_data['negator']
                getkeylists[getkey].append(form.get_getparam())
        for k, v in getkeylists.items():
            qdict.setlist(k, v)
        return redirect('{}?{}'.format(reverse('results'), qdict.urlencode()))

    elif request.method == 'GET':
        return render(request, 'ringapp/search.html', {
            'asymm_formset': forms.AsymmSearchFormSet(prefix='asymm'),
            'symm_formset': forms.SymmSearchFormSet(prefix='symm')
        })
    else:
        return HttpResponseNotAllowed(['get', 'post'])


@require_http_methods(['GET', 'POST'])
def commsearchpage(request):
    if request.method == 'POST':
        comm_formset = forms.CommSearchFormSet(request.POST, request.FILES, prefix='comm')
        commutative = Property.objects.get(name='commutative')
        qdict = QueryDict('', mutable=True)
        # Include commutativity by default in this search
        getkeylists = {'H': [commutative.id], 'L': []}
        for form in comm_formset:
            form.full_clean()
            if form.is_valid():
                getkey = form.cleaned_data['negator']
                getkeylists[getkey].append(form.get_getparam())
        for k, v in getkeylists.items():
            qdict.setlist(k, v)
        return redirect('{}?{}'.format(reverse('results'), qdict.urlencode()))

    elif request.method == 'GET':
        return render(request, 'ringapp/commsearch.html', {
            'comm_formset': forms.CommSearchFormSet(prefix='comm'),
        })
    else:
        return HttpResponseNotAllowed(['get', 'post'])


@ratelimit(key='header:x-forwarded-for', rate='50/h', method='GET', block=True)
@require_GET
def resultspage(request):
    if request.method == 'GET' and ('has' in request.GET or 'lacks' in request.GET):
        # This is an old-style search we need to support!
        has = request.GET.getlist('has')
        lacks = request.GET.getlist('lacks')
        trans_has = [PROPSV1_TO_TERMSV2[pid] for pid in has]
        trans_lacks = [PROPSV1_TO_TERMSV2[pid] for pid in lacks]
        qdict = QueryDict('', mutable=True)
        qdict.setlist('H', trans_has)
        qdict.setlist('L', trans_lacks)
        return redirect('{}?{}'.format(reverse('results'), qdict.urlencode()))

    elif request.method == 'GET':
        has = request.GET.getlist('H')
        lacks = request.GET.getlist('L')
        has_readable = [forms.term_to_readable(x) for x in has]
        lacks_readable = [forms.term_to_readable(x) for x in lacks]

        terms = ['H' + item for item in has]
        terms.extend(['L' + item for item in lacks])
        results, weak_results = ring_search(terms)
        is_asymmetric_search = detect_asymmetric_search(terms)
        if is_asymmetric_search:
            mirror_results, mirror_weak_results = ring_search(mirror_search_terms(terms))
            has_readable = [' '.join(pair) for pair in has_readable]
            lacks_readable = [' '.join(pair) for pair in lacks_readable]
        else:
            has_readable = [pair[0] for pair in has_readable]
            lacks_readable = [pair[0] for pair in lacks_readable]
            mirror_results, mirror_weak_results = None, None

        context = {
            'is_asymm_search': is_asymmetric_search,
            'results': results,
            'weak_results': weak_results,
            'mirror_results': mirror_results,
            'mirror_weak_results': mirror_weak_results,
            'has_readable': has_readable,
            'lacks_readable': lacks_readable,
         }

        return render(request, 'ringapp/results.html', context)

    else:
        return redirect(reverse('search'))


@require_GET
def commresultspage(request):
    if request.method == 'GET' and ('has' in request.GET or 'lacks' in request.GET):
        # This is an old-style commutative search we need to support!
        has = request.GET.getlist('has')
        lacks = request.GET.getlist('lacks')
        trans_has = [PROPSV1COMM_TO_TERMSV2[pid] for pid in has]
        comm = Property.objects.get(name='commutative')
        trans_has.append(comm.id)
        trans_lacks = [PROPSV1COMM_TO_TERMSV2[pid] for pid in lacks]
        qdict = QueryDict('', mutable=True)
        qdict.setlist('H', trans_has)
        qdict.setlist('L', trans_lacks)
        return redirect('{}?{}'.format(reverse('results'), qdict.urlencode()))

    else:
        return redirect(reverse('csearch'))


class KeywordSearchPage(TemplateView):
    def get(self, request, *args, **kwargs):
        if 'kwd' in self.request.GET and is_ratelimited(request, key='header:x-forwarded-for',
                                                        rate='20/h', increment=True,
                                                        group=__name__+'.KeywordSearchPage'):
            raise Ratelimited
        return super().get(request, *args, **kwargs)

    @property
    def template_name(self):
        if 'kwd' in self.request.GET:
            return 'ringapp/keywordresults.html'
        else:
            return 'ringapp/keywordsearch.html'

    def get_context_data(self, **kwargs):
        context = super(KeywordSearchPage, self).get_context_data(**kwargs)
        if 'kwd' not in self.request.GET:
            form = forms.KeywordSearchForm()
            context['form'] = form
            return context
        else:
            kids = [int(thing) for thing in self.request.GET.getlist('kwd')]
            kwds = [Keyword.objects.get(pk=x) for x in kids]
            results = Ring.objects.all()
            for kwd in kwds:
                results = [ring for ring in results if kwd in ring.keywords.all()]

            context.update({'kwds': kwds, 'results': results})
            return context


class KeywordDetailView(DetailView):
    model = Keyword
    template_name = 'ringapp/keyword_detail.html'


class RingList(ListView):
    model = Ring
    template_name = 'ringapp/ring_list.html'

    def get_queryset(self):
        queryset = super().get_queryset()

        # total properties defined for all rings (not just commutative ones)
        total = 2*float(Property.objects.filter(commutative_only=False, symmetric=False).count())
        total += Property.objects.filter(commutative_only=False, symmetric=True).count()

        # now need to indicate what percentage is known for each ringproperty pairing
        scores = completeness_scores(include_commutative=False)
        for obj in queryset:
            if obj.id in scores:
                obj.num_known = round(scores[obj.id]/total, 2)
            else:
                obj.num_known = 0.0

        return queryset


class CommRingList(ListView):
    model = Ring
    template_name = 'ringapp/commring_list.html'

    def get_queryset(self):
        # Just show commutative rings
        queryset = self.model.objects.filter(is_commutative=True)

        # total properties available for all rings (including commutative ones)
        total = 2*float(Property.objects.filter(symmetric=False).count())
        total += Property.objects.filter(symmetric=True).count()

        # now need to indicate what percentage is known for each ringproperty pairing
        scores = completeness_scores(include_commutative=True)
        for obj in queryset:
            if obj.id in scores:
                obj.num_known = round(scores[obj.id]/total, 2)
            else:
                obj.num_known = 0.0

        return queryset


class PropertyList(ListView):
    model = Property
    
    def get_queryset(self):
        return Property.objects.order_by('name')


class CommPropertyRedirect(RedirectView):
    permanent = True

    def get_redirect_url(self, *args, **kwargs):
        # map old commproperty id to the new ids
        kwargs['pk'] = PROPSV1COMM_TO_TERMSV2[kwargs['pk']].strip('lr')
        return reverse('property-detail', kwargs=kwargs)


# TODO: make this available as a special privilege
# class LogicList(ListView):
#     model = Logic
#
#     def get_queryset(self):
#         Logic.objects.filter(option='on')
#


class RingDetail(DetailView):
    model = Ring
    template_name = 'ringapp/ring_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        obj = context['object']
        obj_props = obj.ringproperty_set.order_by('property__name')
        if not obj.is_commutative:
            obj_props = obj_props.filter(property__commutative_only=False)

        props = Property.objects.all()
        if not obj.is_commutative:
            props = props.filter(commutative_only=False)

        # This effectively outer-joins
        prop_join = {prop: (None, None, prop.symmetric) for prop in props}
        for obj_rp in obj_props:
            prop_join[obj_rp.property] = (obj_rp.has_on_left, obj_rp.has_on_right, obj_rp.property.symmetric)

        prop_join = [(prop,) + values for prop, values in prop_join.items()]
        prop_join.sort(key=lambda x: x[0].name)
        symmetric_props = [item for item in prop_join if item[-1] is True]
        asymmetric_props = [item for item in prop_join if item[-1] is False]

        if obj.krull_dim:
            if isinf(obj.krull_dim):
                krull_disp = '$\infty$'
            else:
                krull_disp = str(int(obj.krull_dim))
        else:
            krull_disp = '(unknown)'

        context['prop_join'] = prop_join
        context['symmetric_props'] = symmetric_props
        context['asymmetric_props'] = asymmetric_props
        context['krull_disp'] = krull_disp

        return context


def errorview(request):
    return HttpResponse(status=501)


class PropertyView(DetailView):
    model = Property
    template_name = 'ringapp/property_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        rps = list(self.object.ringproperty_set.all())
        if not self.object.symmetric:
            onleft = [rp.has_on_left for rp in rps]
            has_left_count = onleft.count(True)
            lacks_left_count = onleft.count(False)
            onright = [rp.has_on_right for rp in rps]
            has_right_count = onright.count(True)
            lacks_right_count = onright.count(False)
            context['has_left_count'] = has_left_count
            context['lacks_left_count'] = lacks_left_count
            context['has_right_count'] = has_right_count
            context['lacks_right_count'] = lacks_right_count
        else:
            onleft = [rp.has_on_left for rp in rps]
            has_count = onleft.count(True)
            lacks_count = onleft.count(False)
            context['has_count'] = has_count
            context['lacks_count'] = lacks_count

        metaproperties = PropertyMetaproperty.objects.filter(property=self.object)
        has_mp = [x.metaproperty for x in metaproperties.filter(has_metaproperty=True)]
        lacks_mp = [x.metaproperty for x in metaproperties.filter(has_metaproperty=False)]

        context.update({
            'metaproperties': metaproperties,
            'has_mp': has_mp,
            'lacks_mp': lacks_mp,
        })

        return context


class SuggestionView(RatelimitMixin, SuccessMessageMixin, CreateView):
    model = Suggestion
    template_name = 'ringapp/contribute.html'
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

    def get_context_data(self, **kwargs):
        context = super(SuggestionView, self).get_context_data(**kwargs)
        with open('ringapp/generated/ring_sugg.txt', 'r') as f:
            ring_sugg = random.choice(f.readlines())
        with open('ringapp/generated/cring_sugg.txt', 'r') as f:
            cring_sugg = random.choice(f.readlines())
        context['ring_sugg'] = ring_sugg
        context['cring_sugg'] = cring_sugg
        return context
        

class ProfileView(LoginRequiredMixin, TemplateView):
    template_name = 'ringapp/profile.html'

    def get_context_data(self, **kwargs):
        context = super(ProfileView, self).get_context_data(**kwargs)
        context['suggestions'] = Suggestion.objects.filter(user=self.request.user)
        
        return context


class DetailTemplateView(TemplateView):
    template_name = None

    def get_context_data(self, **kwargs):
        context = super().get_context_data()
        ring = Ring.objects.get(id=kwargs['pk'])
        template = ring.optional_template
        if template == '':
            template = 'no_expanded_details.html'
        self.template_name = 'ringapp/expanded_details/' + template
        context['ring'] = ring

        return context


class TheoremDetail(DetailView):
    template_name = 'ringapp/theorem_detail.html'
    model = Theorem


class NewsList(ListView):
    model = News
    template_name = 'ringapp/news_list.html'

    def get_queryset(self):
        return News.objects.order_by('-id')


class NewsDetail(DetailView):
    model = News
    template_name = 'ringapp/news_detail.html'


class CitationList(ListView):
    model = Publication
    template_name = 'ringapp/bibliography.html'

    def get_queryset(self):
        qs = super().get_queryset()
        qs = qs.exclude(authors='nobody')
        qs = sorted(qs, key=lambda x: x.author_lasts)
        return qs


@staff_member_required
def processor(request):
    if request.method == 'POST':  # If the form has been submitted...
        form = forms.RingSelector(request.POST)  # A form bound to the POST data
        if form.is_valid():  # All validation rules pass
            # Process the data in form.cleaned_data
            form.full_clean()
            ring = form.cleaned_data['ring']

            log_eng = LogicEngine()
            MAX_ITER = 5
            counter = 0
            num_results = 1

            try:
                while counter < MAX_ITER and num_results > 0:
                    num_results = log_eng.process_ring(ring)
                    counter += 1

                if counter == MAX_ITER:
                    msg = _('Processing hit maximum number of iterations: {}'.format(time.time()))
                else:
                    msg = _('Processing successfully completed: {}'.format(time.time()))

            except Exception as exc:
                msg = _('Processing unsuccessful: An exception occurred: {!r}'.format(exc))

            context = {'form': form, 'msg': msg, 'title': _('Logic processor'),
                       'is_popup': False, 'has_permission': True, 'site_url': '/'}
            return render(request, 'admin/processor.html', context)

    else:
        form = forms.RingSelector()  # An unbound form

    context = {'form': form, 'title': _('Logic processor'), 'is_popup': False, 'msg': '',
               'has_permission': True, 'site_url': '/'}

    return render(request, 'admin/processor.html', context)


class RatelimitedLoginView(LoginView):
    @ratelimit(key='header:x-forwarded-for', rate='5/d', block=False)
    @ratelimit(key='post:username', rate='5/d', block=False)
    @ratelimit(key='post:password', rate='10/d', block=False)
    def post(self, request, *args, **kwargs):
        """
        Choose the right form based on ratelimiting
        """
        was_limited = getattr(request, 'limited', False)
        vlogger.error('was limited was {}'.format(was_limited))
        if not was_limited:
            form = self.get_form(forms.AuthenticationForm)
        else:
            form = self.get_form(forms.RatelimitedAuthenticationForm)
        if form.is_valid():
            return self.form_valid(form)
        else:
            return self.form_invalid(form)
