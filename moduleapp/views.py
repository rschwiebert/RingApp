from django.http import HttpResponseNotAllowed, QueryDict
from django.urls import reverse
from django.db.models import Count
from django.views.decorators.http import require_http_methods, require_GET
from django.views.generic import DetailView, ListView, TemplateView, RedirectView
from ratelimit.decorators import ratelimit

from moduleapp.models import Property, Module, ModuleProperty, PropertyMetaproperty
from django.shortcuts import render, redirect
from moduleapp import forms

from ringapp.SearchUtils import module_search


class ModuleList(ListView):
    model = Module
    template_name = 'moduleapp/module_list.html'

    def get_queryset(self):
        total = float(Property.objects.filter().count())
        queryset = super().get_queryset().annotate(percent_known=Count('moduleproperty')/total)
        return queryset


class ModuleDetail(DetailView):
    model = Module
    template_name = 'moduleapp/module_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        obj = context['object']
        obj_props = obj.moduleproperty_set.order_by('property__name')


        props = Property.objects.all()

        # This effectively outer-joins
        prop_join = {prop: (None,) for prop in props}
        for obj_rp in obj_props:
            prop_join[obj_rp.property] = (obj_rp.has,)

        prop_join = [(prop,) + values for prop, values in prop_join.items()]
        context['prop_join'] = prop_join


        # context['dimensions'] = obj.moduledimension_set.all().order_by('dimension_type__name')
        # context['subsets'] = obj.modulesubset_set.all().order_by('subset_type__name')

        return context


class PropertyList(ListView):
    model = Property
    template = 'moduleapp/property_list.html'


class PropertyView(DetailView):
    model = Property
    template = 'moduleapp/property_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        has_count = ModuleProperty.objects.filter(property=context['object'], has=True).count()
        lacks_count = ModuleProperty.objects.filter(property=context['object'], has=False).count()
        context['has_count'] = has_count
        context['lacks_count'] = lacks_count
        metaproperties = PropertyMetaproperty.objects.filter(property=self.object)
        context['metaproperties'] = metaproperties
        context['has_mp'] = metaproperties.filter(has_metaproperty=True)
        context['lacks_mp'] = metaproperties.filter(has_metaproperty=False)
        return context


@require_http_methods(['GET', 'POST'])
def searchpage(request):
    if request.method == 'POST':
        formset = forms.SearchFormSet(request.POST, request.FILES, prefix='mods')

        qdict = QueryDict('', mutable=True)
        getkeylists = {'H': [], 'L': []}
        for form in formset.forms:
            form.full_clean()
            if form.is_valid():
                getkey = form.cleaned_data['negator']
                getkeylists[getkey].append(form.get_getparam())
        for k, v in getkeylists.items():
            qdict.setlist(k, v)
        return redirect('{}?{}'.format(reverse('module-results'), qdict.urlencode()))

    elif request.method == 'GET':
        return render(request, 'moduleapp/search.html', {
            'formset': forms.SearchFormSet(prefix='mods'),
        })
    else:
        return HttpResponseNotAllowed(['get', 'post'])


@ratelimit(key='header:x-forwarded-for', rate='50/h', method='GET', block=True)
@require_GET
def resultspage(request):

    if request.method == 'GET':
        has = request.GET.getlist('H')
        lacks = request.GET.getlist('L')
        has_readable = [forms.term_to_readable(x) for x in has]
        lacks_readable = [forms.term_to_readable(x) for x in lacks]

        terms = ['H' + item for item in has]
        terms.extend(['L' + item for item in lacks])
        results, weak_results = module_search(terms)

        context = {
            'results': results,
            'weak_results': weak_results,
            'has_readable': has_readable,
            'lacks_readable': lacks_readable,
         }

        return render(request, 'moduleapp/results.html', context)

    else:
        return redirect(reverse('module-search'))
