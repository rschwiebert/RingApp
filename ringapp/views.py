import json
import time
import logging
from collections import OrderedDict
from datetime import date

from django.contrib.auth.views import LoginView
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.decorators import login_required
from django.contrib.messages.views import SuccessMessageMixin
from django.core.cache import cache
from django.core.urlresolvers import reverse
from django.http import HttpResponse, QueryDict, HttpResponseNotAllowed, Http404, HttpResponseNotModified
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

from ringapp.models import Ring, Property, PropertyMetaproperty, Dimension, RingDimension
from ringapp.models import Theorem, Suggestion, Keyword, News, Publication, Erratum
from ringapp import forms
from ringapp.constants import PROPSV1_TO_TERMSV2, PROPSV1COMM_TO_TERMSV2

from ringapp.SearchUtils import (mirror_search_terms,
                                 detect_asymmetric_search,
                                 ring_search, LogicEngine,
                                 completeness_scores)
from ringapp.SuggestionUtils import simple_irreversible_logics, suggest_asymm_examples

vlogger = logging.getLogger(__name__)
log_eng = LogicEngine()


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

        context['prop_join'] = prop_join
        context['symmetric_props'] = symmetric_props
        context['asymmetric_props'] = asymmetric_props
        context['dimensions'] = obj.ringdimension_set.all().order_by('dimension_type__name')
        context['subsets'] = obj.ringsubset_set.all().order_by('subset_type__name')

        return context


class ErrataList(ListView):
    model = Erratum

    def get_queryset(self):
        return Erratum.objects.order_by('error_location')


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
        has_mp = metaproperties.filter(has_metaproperty=True)
        lacks_mp = metaproperties.filter(has_metaproperty=False)

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
        

class ProfileView(LoginRequiredMixin, TemplateView):
    template_name = 'ringapp/profile.html'

    def get_context_data(self, **kwargs):
        context = super(ProfileView, self).get_context_data(**kwargs)
        suggestions = Suggestion.objects.filter(user=self.request.user).order_by('-id')
        stats = {
            "accepted": suggestions.filter(status=1).count(),
            "declined": suggestions.filter(status=-1).count(),
            "pending": suggestions.filter(status=0).count(),
            "info": suggestions.filter(status=-2).count(),
        }

        context['unread_suggestions'] = suggestions.filter(unread=True)
        context['old_suggestions'] = suggestions.filter(unread=False)
        context['stats'] = stats

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


class DimensionView(TemplateView):
    template_name = 'ringapp/dimension_list.html'
    http_method_names = ['get', ]

    def get(self, request, *args, **kwargs):
        context = self.get_context_data(**kwargs)
        dtype = request.GET.get('dimension_type')
        sort = request.GET.get('sort')
        cfilter = request.GET.get('filter')
        objects = RingDimension.objects.none()
        current_dtype = None
        absent_rings = None
        if dtype is not None:
            objects = RingDimension.objects.filter(dimension_type_id=dtype).order_by('ring__name')
            current_dtype = Dimension.objects.get(id=dtype)
            present_rings = {item.ring.id for item in objects}
            absent_rings = Ring.objects.exclude(id__in=present_rings).order_by('name')
            if cfilter == 'c':
                objects = objects.filter(ring__is_commutative=True)
                absent_rings = absent_rings.filter(is_commutative=True)

        if sort == 'l':
            objects = objects.order_by('left_dimension', 'ring__name')

        elif sort == 'r':
            objects = objects.order_by('right_dimension', 'ring__name')

        context['dim_types'] = Dimension.objects.all()
        context['objects'] = objects
        context['form'] = forms.DimensionSelector()
        context['dtype'] = current_dtype
        context['absent_rings'] = absent_rings
        context['cfilter'] = cfilter
        context['sort'] = sort

        return self.render_to_response(context)


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


def citeview(request):
    today = date.today()
    styles = OrderedDict({
        'Bibtex': '''@misc{schwiebert_2014,
    title={DaRT - Home}, 
    url={https://ringtheory.herokuapp.com/}, 
    journal={Database of Ring Theory}, 
    author={Schwiebert, Ryan C.}, 
    year={2014}, 
    month={Dec}, 
    note={Accessed ''' + today.strftime('%B %d, %Y') + '}}',

        'IEEE': 'R. C. Schwiebert, "DaRT - Home", Database of Ring Theory, 2014. [Online]. '
                'Available: https://ringtheory.herokuapp.com. [Accessed: {}].'.format(today.strftime('%d- %b- %Y')),

        'MLA': 'Schwiebert, Ryan C. "DaRT - Home". Database Of Ring Theory, 2014, https://ringtheory.herokuapp.com. '
               'Accessed 28 June 2018.'.format(today.strftime('%d %B %Y')),
        'AMA': 'Schwiebert R. C. DaRT - Home. Database of Ring Theory. 2014. '
               'Available at: https://ringtheory.herokuapp.com. Accessed {}.'.format(today.strftime('%B %d, %Y')),
        'APA': 'Schwiebert, R. C. (2014). DaRT - Home. Retrieved from https://ringtheory.herokuapp.com',
        'Chicago': 'Schwiebert, Ryan C. 2014. "DaRT - Home". Database Of Ring Theory. https://ringtheory.herokuapp.com.',

        'Harvard': 'Schwiebert, R. C. (2014). DaRT - Home. [online] Database of Ring Theory. '
                   'Available at: https://ringtheory.herokuapp.com [Accessed {}].'.format(today.strftime('%d %b. %Y')),
    })
    context = {'styles': styles}
    return render(request, 'ringapp/cite.html', context)


@staff_member_required
def processor(request):
    if request.method == 'POST':  # If the form has been submitted...
        form = forms.RingSelector(request.POST)  # A form bound to the POST data
        if form.is_valid():  # All validation rules pass
            # Process the data in form.cleaned_data
            form.full_clean()
            ring = form.cleaned_data['ring']

            MAX_ITER = 1
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
                from django.core.mail import send_mail
                from traceback import format_stack
                from django.conf import settings

                send_mail('processor bug', repr(format_stack()),
                          settings.REGISTRATION_DEFAULT_FROM_EMAIL,
                          [settings.REGISTRATION_DEFAULT_FROM_EMAIL])

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
        if not was_limited:
            form = self.get_form(forms.AuthenticationForm)
        else:
            form = self.get_form(forms.RatelimitedAuthenticationForm)
        if form.is_valid():
            return self.form_valid(form)
        else:
            return self.form_invalid(form)


def ratelimited_view(request, exception):
    vlogger.error('Request was ratelimited: {}'.format(request))
    return render(request, 'ringapp/ratelimited.html', {'exception': exception})


def inspiration_view(request):
    asymm_suggestions = cache.get('asymm_suggestions')
    if asymm_suggestions is None:
        asymm_suggestions = suggest_asymm_examples()
        cache.set('asymm_suggestions', asymm_suggestions, 24*60*60)

    simple_irreversible = cache.get('simple_irreversible')
    if simple_irreversible is None:
        simple_irreversible = simple_irreversible_logics()
        cache.set('simple_irreversible', simple_irreversible)

    context = {'asymm_sugg': asymm_suggestions,
               'simple_sugg': simple_irreversible}

    return render(request, 'ringapp/inspiration.html', context)


@login_required
def live_unread_notification_count(request):
    if request.is_ajax:
        unread_notifications = Suggestion.objects.filter(user=request.user, unread=True).count()
        data = {"unread_notifications": unread_notifications}
        json_data = json.dumps(data)
        return HttpResponse(json_data, content_type='application/json')
    else:
        return HttpResponseNotModified(content_type='application/json')


@login_required
@ratelimit(key='user', rate='50/h', block=True)
def toggle_read(request, *args, **kwargs):
    if request.is_ajax:
        # logic which toggles the field on the object
        sugg_id = request.GET['suggestion_id']
        try:
            sugg = Suggestion.objects.filter(user=request.user).get(id=sugg_id)
        except Suggestion.ObjectDoesNotExist:
            return Http404('No modifiable entry found for this request.')
        sugg.unread = True if request.GET['unread'] == 'true' else False
        sugg.save()
        return HttpResponse()
    else:
        return HttpResponseNotModified()
