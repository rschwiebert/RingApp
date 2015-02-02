from django.shortcuts import render
from django.http import HttpResponse, Http404

from django.template import RequestContext, loader
from ringapp.models import Ring, Property, Logic, RingProperty, Invariance
from ringapp.models import CommProperty, CommLogic, CommRingProperty, CommInvariance
from ringapp.models import Publication, Theorem
from ringapp.forms import SearchForm, CommSearchForm, ContribSelector, RingSelector
import re
import random

from AdminUtils import *


def index(request):
    template = loader.get_template('ringapp/index.html')
    context = RequestContext(request, {})
    return HttpResponse(template.render(context))


def searchpage(request):
    if request.method == 'POST':  # If the form has been submitted...
        form = SearchForm(request.POST)  # A form bound to the POST data
        if form.is_valid():  # All validation rules pass
            # Process the data in form.cleaned_data
            # ...
            template = loader.get_template('ringapp/results.html')
            datadict = form.cleaned_data
            context = RequestContext(request, {'datadict': datadict})
            return HttpResponse(template.render(context))
    else:
        form = SearchForm()  # An unbound form

    return render(request, 'ringapp/search.html', {
        'form':  form,
    })   


def commsearchpage(request):
    if request.method == 'POST':  # If the form has been submitted...
        form = CommSearchForm(request.POST)  # A form bound to the POST data
        if form.is_valid():  # All validation rules pass
            # Process the data in form.cleaned_data
            # ...
            template = loader.get_template('ringapp/commresults.html')
            datadict = form.cleaned_data
            context = RequestContext(request, {'datadict': datadict})
            return HttpResponse(template.render(context))
    else:
        form = CommSearchForm()  # An unbound form

    return render(request, 'ringapp/commsearch.html', {
        'form':  form,
    })


def results(request):
    template = loader.get_template('ringapp/results.html')
    values = request.GET.items()
    scope = dict(values)['scope']
    values.remove(('scope', scope))
    values = [x for x in values if x[1] != '0']
    
    has = [int(x[1]) for x in values if re.search(re.compile('^has'), x[0])is not None]
    lacks = [int(x[1]) for x in values if re.search(re.compile('^lacks'), x[0]) is not None]
    has_names = [Property.objects.get(pk=x).name for x in has]
    lacks_names = [Property.objects.get(pk=x).name for x in lacks] 
    has_string = ' and '.join(has_names)
    lacks_string = ' or '.join(lacks_names)
    
    main_results = find_rings(scope, has=has, lacks=lacks)
    mirror_results = mirror_search(scope, has=has, lacks=lacks)
    
    context = RequestContext(request, {'values': values,
                                       'has': has,
                                       'lacks': lacks,
                                       'scope': scope,
                                       'main_results': main_results,
                                       'mirror_results': mirror_results,
                                       'has_string': has_string,
                                       'lacks_string': lacks_string,
                                       })
    return HttpResponse(template.render(context))


def commresults(request):
    template = loader.get_template('ringapp/commresults.html')
    values = request.GET.items()
    scope = dict(values)['scope']
    values.remove(('scope', scope))
    values = [x for x in values if x[1] != '0']
    
    has = [int(x[1]) for x in values if re.search(re.compile('^has'), x[0]) is not None]
    lacks = [int(x[1]) for x in values if re.search(re.compile('^lacks'), x[0]) is not None]
    has_names = [CommProperty.objects.get(pk=x).name for x in has]
    lacks_names = [CommProperty.objects.get(pk=x).name for x in lacks] 
    has_string = ' and '.join(has_names)
    lacks_string = ' or '.join(lacks_names)
    
    main_results = find_rings(scope, has=has, lacks=lacks, comm=True)
    
    context = RequestContext(request, {'values': values,
                                       'has': has,
                                       'lacks': lacks,
                                       'scope': scope,
                                       'main_results': main_results,
                                       'has_string': has_string,
                                       'lacks_string': lacks_string,
                                       })
    return HttpResponse(template.render(context))


def browserings(request):
    ring_list = Ring.objects.order_by('ring_id')
    template = loader.get_template('ringapp/browserings.html')
    context = RequestContext(request, {
        'ring_list':  ring_list,
    })
    return HttpResponse(template.render(context))


def browsecommrings(request):
    ring_list = Ring.objects.filter(ringproperty__property=Property.objects.get(pk=1),
                                    ringproperty__has_property=1).order_by('ring_id')
    template = loader.get_template('ringapp/browsecommrings.html')
    context = RequestContext(request, {
        'ring_list':  ring_list,
    })
    return HttpResponse(template.render(context))


def browseprops(request):
    prop_list = Property.objects.order_by('name')
    template = loader.get_template('ringapp/browseprops.html')
    context = RequestContext(request, {
        'prop_list':  prop_list,
    })
    return HttpResponse(template.render(context))


def browsecommprops(request):
    prop_list = CommProperty.objects.order_by('name')
    template = loader.get_template('ringapp/browsecommprops.html')
    context = RequestContext(request, {
        'prop_list':  prop_list,
    })
    return HttpResponse(template.render(context))


def browselogic(request):
    template = loader.get_template('ringapp/browselogics.html')
    logics = Logic.objects.all().filter(option='on')
    context = RequestContext(request, {'logics': logics})
    return HttpResponse(template.render(context))


def browsecommlogic(request):
    template = loader.get_template('ringapp/browsecommlogics.html')
    logics = CommLogic.objects.filter(option='on')
    context = RequestContext(request, {'logics': logics})
    return HttpResponse(template.render(context))


def viewlogic(request, logic_id):
    lobjs = Logic.objects.get(logic_id=logic_id)
    context = RequestContext(request, {
        'L': lobjs
    })
    template = loader.get_template('ringapp/viewlogic.html')
    return HttpResponse(template.render(context))


def viewcommlogic(request, logic_id):
    lobjs = CommLogic.objects.get(logic_id=logic_id)
    context = RequestContext(request, {
        'L': lobjs
    })
    template = loader.get_template('ringapp/viewcommlogic.html')
    return HttpResponse(template.render(context))


def viewring(request, ring_id):
    r = Ring.objects.get(ring_id=ring_id)
    has_props = []
    lacks_props = []
    other_props = []
    for p in Property.objects.all():
        if r.ringproperty_set.filter(property=p, has_property=1):
            has_props.append((p.name.lower(), p))
        elif r.ringproperty_set.filter(property=p, has_property=0):
            lacks_props.append((p.name.lower(), p))
        else:
            other_props.append((p.name.lower(), p))
    has_props.sort()
    lacks_props.sort()
    other_props.sort()

    if has_props:
        has_props = zip(*has_props)[1]
    if lacks_props:
        lacks_props = zip(*lacks_props)[1]
    if other_props:
        other_props = zip(*other_props)[1]
    ref_list = ['%s, %s, %s, (%d). %s' % (x.publication.authors,
                                          x.publication.title,
                                          x.publication.details,
                                          x.publication.pub_date.year,
                                          x.location) for x in r.reference.all()]

    context = RequestContext(request, {
        'r': r,
        'has_props': has_props,
        'lacks_props': lacks_props,
        'other_props': other_props,
        'ref_list': ref_list,
    })
    template = loader.get_template('ringapp/viewring.html')
    return HttpResponse(template.render(context))


def viewcommring(request, ring_id):
    r = Ring.objects.get(ring_id=ring_id)
    has_props = []
    lacks_props = []
    other_props = []
    for p in CommProperty.objects.all():
        if r.commringproperty_set.filter(property=p, has_property=1):
            has_props.append((p.name.lower(), p))
        elif r.commringproperty_set.filter(property=p, has_property=0):
            lacks_props.append((p.name.lower(), p))
        else:
            other_props.append((p.name.lower(), p))
    has_props.sort()
    lacks_props.sort()
    other_props.sort()
    if has_props:
        has_props = zip(*has_props)[1]
    if lacks_props:
        lacks_props = zip(*lacks_props)[1]
    if other_props:
        other_props = zip(*other_props)[1]
    ref_list = ['%s, %s, %s, (%d). %s' % (x.publication.authors,
                                          x.publication.title,
                                          x.publication.details,
                                          x.publication.pub_date.year,
                                          x.location) for x in r.reference.all()]
    context = RequestContext(request, {
        'r': r,
        'has_props': has_props,
        'lacks_props': lacks_props,
        'other_props': other_props,
        'ref_list': ref_list,
    })
    template = loader.get_template('ringapp/viewcommring.html')
    return HttpResponse(template.render(context))
    

def viewprop(request, property_id):
    prop = Property.objects.get(property_id=property_id)
    has_url = '?scope=n&has1=%s&has2=0&has3=0&lacks1=0&lacks2=0&lacks3=0' % property_id
    lacks_url = '?scope=n&has1=0&has2=0&has3=0&lacks1=%s&lacks2=0&lacks3=0' % property_id
    # unknown_url =
    hasnum = prop.ringproperty_set.filter(has_property=1).count()
    lacksnum = prop.ringproperty_set.filter(has_property=0).count()
    metaproperties = Invariance.objects.filter(property=prop)
    has_mp = [x.invarianttype for x in metaproperties.filter(has_metaproperty=True)]
    lacks_mp = [x.invarianttype for x in metaproperties.filter(has_metaproperty=False)]

    context = RequestContext(request, {
        'property_id':  property_id,
        'prop': prop,
        'hasnum': hasnum,
        'lacksnum': lacksnum,
        'has_url': has_url,
        'metaproperties': metaproperties,
        'lacks_url': lacks_url,
        'has_mp': has_mp,
        'lacks_mp': lacks_mp,
    })
    template = loader.get_template('ringapp/viewprop.html')
    return HttpResponse(template.render(context))    


def viewcommprop(request, property_id):
    prop = CommProperty.objects.get(property_id=property_id)
    has_url = '?scope=n&has1=%s&has2=0&has3=0&lacks1=0&lacks2=0&lacks3=0' % property_id
    lacks_url = '?scope=n&has1=0&has2=0&has3=0&lacks1=%s&lacks2=0&lacks3=0' % property_id
    # unknown_url =
    hasnum = prop.commringproperty_set.filter(has_property=1).count()
    lacksnum = prop.commringproperty_set.filter(has_property=0).count()
    metaproperties = CommInvariance.objects.filter(property=prop)
    has_mp = [x.invarianttype for x in metaproperties.filter(has_metaproperty=True)]
    lacks_mp = [x.invarianttype for x in metaproperties.filter(has_metaproperty=False)]

    context = RequestContext(request, {
        'property_id':  property_id,
        'prop': prop,
        'hasnum': hasnum,
        'lacksnum': lacksnum,
        'has_url': has_url,
        'metaproperties': metaproperties,
        'lacks_url': lacks_url,
        'has_mp': has_mp,
        'lacks_mp': lacks_mp,
    })
    template = loader.get_template('ringapp/viewcommprop.html')
    return HttpResponse(template.render(context))


def about(request):
    context = RequestContext(request, {})
    template = loader.get_template('ringapp/about.html')
    return HttpResponse(template.render(context))


def people(request):
    template = loader.get_template('ringapp/people.html')
    context = RequestContext(request, {})
    return HttpResponse(template.render(context))


def resources(request):
    template = loader.get_template('ringapp/resources.html')
    context = RequestContext(request, {})
    return HttpResponse(template.render(context))


def contribute(request):
    if request.method == 'POST':  # If the form has been submitted...
        chooser = ContribSelector(request.POST)  # A form bound to the POST data
        if chooser.is_valid():  # All validation rules pass
            # Process the data in form.cleaned_data
            # ...
            template = loader.get_template('ringapp/suggestions.html')
            # choice = chooser.cleaned_data['option']
            context = RequestContext(request, {})
            return HttpResponse(template.render(context))
    else:
        chooser = ContribSelector()  # An unbound form
        template = loader.get_template('ringapp/contribute.html')
        context = RequestContext(request, {'chooser': chooser})
        return HttpResponse(template.render(context))


def suggestions(request):
    template = loader.get_template('ringapp/suggestions.html')
    data = dict(item for item in request.GET.items())
    # cite_sugg = 
    with open('ringapp/generated/ring_sugg.txt', 'r') as f:
        ring_sugg = random.choice(f.readlines())
    with open('ringapp/generated/cring_sugg.txt', 'r') as f:
        cring_sugg = random.choice(f.readlines())
    # data['cite_sugg'] = cite_sugg
    data['ring_sugg'] = ring_sugg
    data['cring_sugg'] = cring_sugg
    context = RequestContext(request, data)
    return HttpResponse(template.render(context))


def browsetheorems(request):
    template = loader.get_template('ringapp/browsetheorems.html')
    theorem_list = Theorem.objects.all()
    context = RequestContext(request, {'theorem_list': theorem_list})
    return HttpResponse(template.render(context))


def viewtheorem(request, theorem_id):
    tobjs = Theorem.objects.get(theorem_id=theorem_id)
    ref_list = ['%s, %s, %s, (%d). %s' % (x.publication.authors,
                                          x.publication.title,
                                          x.publication.details,
                                          x.publication.pub_date.year,
                                          x.location) for x in tobjs.reference.all()]
    context = RequestContext(request, {
        'T': tobjs,
        'ref_list': ref_list,
    })
    template = loader.get_template('ringapp/viewtheorem.html')
    return HttpResponse(template.render(context))


def bibliography(request):
    template = loader.get_template('ringapp/bibliography.html')
    bib = ['%s, %s, %s, (%d).' % (x.authors,
                                  x.title,
                                  x.details,
                                  x.pub_date.year) for x in Publication.objects.exclude(id=6)]
    bib.sort()
    context = RequestContext(request, {'bibliography': bib})
    return HttpResponse(template.render(context))


def processor(request):
    if request.method == 'GET':  # If the form has been submitted...
        form = RingSelector(request.GET)  # A form bound to the POST data
        if form.is_valid():  # All validation rules pass
            # Process the data in form.cleaned_data
            # ...
            msg = 'submission happened'
            template = loader.get_template('admin/processor.html')
            context = RequestContext(request, {'form': form, 'msg': msg})
            return HttpResponse(template.render(context))
    else:
        form = RingSelector()  # An unbound form
    template = loader.get_template('admin/processor.html')
    context = RequestContext(request, {'form': form})
    return HttpResponse(template.render(context))


def testview(request):
    template = loader.get_template('')
    context = RequestContext(request, {})
    return HttpResponse(template.render(context))