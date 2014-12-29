from django.shortcuts import render
from django.http import HttpResponse, Http404

from django.template import RequestContext, loader
from ringapp.models import Ring, Property, Logic, RingProperty
from ringapp.models import CommProperty,CommLogic,CommRingProperty
from ringapp.forms import SearchForm, CommSearchForm, ContribSelector
import re

from AdminUtils import *

def index(request):
    template =  loader.get_template('ringapp/index.html')
    context = RequestContext(request,{})
    return HttpResponse(template.render(context))

def searchpage(request):
    if request.method == 'POST': # If the form has been submitted...
        form = SearchForm(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            # Process the data in form.cleaned_data
            # ...
            template =  loader.get_template('ringapp/results.html')
            datadict = form.cleaned_data
            context = RequestContext(request,{'datadict':datadict})
            return HttpResponse(template.render(context))
    else:
        form = SearchForm() # An unbound form

    return render(request, 'ringapp/search.html', {
        'form': form,
    })   
    
def commsearchpage(request):
    if request.method == 'POST': # If the form has been submitted...
        form = CommSearchForm(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            # Process the data in form.cleaned_data
            # ...
            template =  loader.get_template('ringapp/commresults.html')
            datadict=form.cleaned_data
            context = RequestContext(request,{'datadict':datadict})
            return HttpResponse(template.render(context))
    else:
        form = CommSearchForm() # An unbound form

    return render(request, 'ringapp/commsearch.html', {
        'form': form,
    })
    
def results(request):
    template =  loader.get_template('ringapp/results.html')
    values = request.GET.items()
    scope = dict(values)['scope']
    values.remove(('scope',scope))
    values = [x for x in values if x[1]!='0' ]
    
    has = [int(x[1]) for x in values if re.search(re.compile('^has'),x[0])!=None]
    lacks = [int(x[1]) for x in values if re.search(re.compile('^lacks'),x[0])!=None]
    has_names = [Property.objects.get(pk=x).name for x in has]
    lacks_names = [Property.objects.get(pk=x).name for x in lacks] 
    has_string = ' and '.join(has_names)
    lacks_string = ' or '.join(lacks_names)
    
    main_results = find_rings(scope, has=has,lacks=lacks)
    mirror_results = mirror_search(scope,has=has,lacks=lacks)
    
    context = RequestContext(request,{'values':values,
                                      'has':has,
                                      'lacks':lacks,
                                      'scope':scope,
                                      'main_results':main_results,
                                      'mirror_results':mirror_results,
                                      'has_string':has_string,
                                      'lacks_string':lacks_string,
                                      })
    return HttpResponse(template.render(context))

def commresults(request):
    template =  loader.get_template('ringapp/commresults.html')
    values = request.GET.items()
    scope = dict(values)['scope']
    values.remove(('scope',scope))
    values = [x for x in values if x[1]!='0' ]
    
    has = [int(x[1]) for x in values if re.search(re.compile('^has'),x[0])!=None]
    lacks = [int(x[1]) for x in values if re.search(re.compile('^lacks'),x[0])!=None]
    has_names = [CommProperty.objects.get(pk=x).name for x in has]
    lacks_names = [CommProperty.objects.get(pk=x).name for x in lacks] 
    has_string = ' and '.join(has_names)
    lacks_string = ' or '.join(lacks_names)
    
    main_results = find_rings(scope, has=has,lacks=lacks,comm=True)
    
    context = RequestContext(request,{'values':values,
                                      'has':has,
                                      'lacks':lacks,
                                      'scope':scope,
                                      'main_results':main_results,
                                      'has_string':has_string,
                                      'lacks_string':lacks_string,
                                      })
    return HttpResponse(template.render(context))
    
def browserings(request):
    ring_list = Ring.objects.order_by('ring_id')
    template =  loader.get_template('ringapp/browserings.html')
    context = RequestContext(request,{
        'ring_list': ring_list,
    })
    return HttpResponse(template.render(context))

def browsecommrings(request):
    ring_list = Ring.objects.filter(ringproperty__property=Property.objects.get(pk=1),ringproperty__has_property=1).order_by('ring_id')
    template =  loader.get_template('ringapp/browsecommrings.html')
    context = RequestContext(request,{
        'ring_list': ring_list,
    })
    return HttpResponse(template.render(context))

    
def browseprops(request):
    prop_list = Property.objects.order_by('name')
    template =  loader.get_template('ringapp/browseprops.html')
    context = RequestContext(request,{
        'prop_list': prop_list,
    })
    return HttpResponse(template.render(context))
    
def browsecommprops(request):
    prop_list = CommProperty.objects.order_by('name')
    template =  loader.get_template('ringapp/browsecommprops.html')
    context = RequestContext(request,{
        'prop_list': prop_list,
    })
    return HttpResponse(template.render(context))
    
def browselogic(request):
    template =  loader.get_template('ringapp/browselogics.html')
    logics = Logic.objects.all().filter(option='on')
    context = RequestContext(request,{'logics':logics})
    return HttpResponse(template.render(context))

def browsecommlogic(request):
    template =  loader.get_template('ringapp/browsecommlogics.html')
    logics = CommLogic.objects.filter(option='on')
    context = RequestContext(request,{
          'logics':logics})
    return HttpResponse(template.render(context))
    
def viewlogic(request,logic_id):
    L = Logic.objects.get(logic_id=logic_id)
    context = RequestContext(request,{
        'L':L
    })
    template =  loader.get_template('ringapp/viewlogic.html')
    return HttpResponse(template.render(context))

def viewcommlogic(request,logic_id):
    L = CommLogic.objects.get(logic_id=logic_id)
    context = RequestContext(request,{
        'L':L
    })
    template =  loader.get_template('ringapp/viewlogic.html')
    return HttpResponse(template.render(context))

def viewring(request,ring_id):
    r=Ring.objects.get(ring_id=ring_id)
    has_props = []
    lacks_props = []
    other_props = []
    for p in Property.objects.all():
        if r.ringproperty_set.filter(property=p,has_property=1):
            has_props.append((p.name.lower(),p))
        elif r.ringproperty_set.filter(property=p,has_property=0):
            lacks_props.append((p.name.lower(),p))
        else:
            other_props.append((p.name.lower(),p))
    has_props.sort()
    lacks_props.sort()
    other_props.sort()
    if has_props:
        has_props = zip(*has_props)[1]
    if lacks_props:
        lacks_props = zip(*lacks_props)[1]
    if other_props:
        other_props = zip(*other_props)[1]
    context = RequestContext(request,{
        'r':r,
        'has_props':has_props,
        'lacks_props':lacks_props,
        'other_props':other_props
    })
    template =  loader.get_template('ringapp/viewring.html')
    return HttpResponse(template.render(context))

def viewcommring(request,ring_id):
    r=Ring.objects.get(ring_id=ring_id)
    has_props = []
    lacks_props = []
    other_props = []
    for p in CommProperty.objects.all():
        if r.commringproperty_set.filter(property=p,has_property=1):
            has_props.append((p.name.lower(),p))
        elif r.commringproperty_set.filter(property=p,has_property=0):
            lacks_props.append((p.name.lower(),p))
        else:
            other_props.append((p.name.lower(),p))
    has_props.sort()
    lacks_props.sort()
    other_props.sort()
    if has_props:
        has_props = zip(*has_props)[1]
    if lacks_props:
        lacks_props = zip(*lacks_props)[1]
    if other_props:
        other_props = zip(*other_props)[1]
    context = RequestContext(request,{
        'r':r,
        'has_props':has_props,
        'lacks_props':lacks_props,
        'other_props':other_props
    })
    template =  loader.get_template('ringapp/viewcommring.html')
    return HttpResponse(template.render(context))
    
def viewprop(request,property_id):
    prop = Property.objects.get(property_id=property_id)
    hasnum = prop.ringproperty_set.filter(has_property=1).count()
    lacksnum = prop.ringproperty_set.filter(has_property=0).count()
    
    has_rings = []
    lacks_rings = []
    other_rings = []
    for r in Ring.objects.all():
        if prop.ringproperty_set.filter(ring=r,has_property=1):
            has_rings.append((r.name.lower(),r))
        elif prop.ringproperty_set.filter(ring=r,has_property=0):
            lacks_rings.append((r.name.lower(),r))
        else:
            other_rings.append((r.name.lower(),r))
    has_rings.sort()
    lacks_rings.sort()
    other_rings.sort()
    has_rings = zip(*has_rings)[1] if has_rings else []
    lacks_rings = zip(*lacks_rings)[1] if lacks_rings else []
    other_rings = zip(*other_rings)[1] if other_rings else []
    
    
    context = RequestContext(request,{
        'property_id': property_id,
        'prop':prop,
        'hasnum':hasnum,
        'lacksnum':lacksnum,
        'has_rings':has_rings,
        'lacks_rings':lacks_rings,
        'other_rings':other_rings
    })
    template =  loader.get_template('ringapp/viewprop.html')
    return HttpResponse(template.render(context))    

def viewcommprop(request,property_id):
    prop = CommProperty.objects.get(property_id=property_id)
    hasnum = prop.commringproperty_set.filter(has_property=1).count()
    lacksnum = prop.commringproperty_set.filter(has_property=0).count()
    
    has_rings = []
    lacks_rings = []
    other_rings = []
    for r in Ring.objects.filter(ringproperty__property_id=1,ringproperty__has_property=1):
        if prop.commringproperty_set.filter(ring=r,has_property=1):
            has_rings.append((r.name.lower(),r))
        elif prop.commringproperty_set.filter(ring=r,has_property=0):
            lacks_rings.append((r.name.lower(),r))
        else:
            other_rings.append((r.name.lower(),r))
    has_rings.sort()
    lacks_rings.sort()
    other_rings.sort()
    has_rings = zip(*has_rings)[1] if has_rings else []
    lacks_rings = zip(*lacks_rings)[1] if lacks_rings else []
    other_rings = zip(*other_rings)[1] if other_rings else []
    
    
    context = RequestContext(request,{
        'property_id': property_id,
        'prop':prop,
        'hasnum':hasnum,
        'lacksnum':lacksnum,
        'has_rings':has_rings,
        'lacks_rings':lacks_rings,
        'other_rings':other_rings
    })
    template =  loader.get_template('ringapp/viewcommprop.html')
    return HttpResponse(template.render(context))
    
    
def about(request):
    context = RequestContext(request,{ })
    template =  loader.get_template('ringapp/about.html')
    return HttpResponse(template.render(context))

def people(request):
    template =  loader.get_template('ringapp/people.html')
    context = RequestContext(request,{})
    return HttpResponse(template.render(context))

def resources(request):
    template =  loader.get_template('ringapp/resources.html')
    context = RequestContext(request,{})
    return HttpResponse(template.render(context))

def contribute(request):
    if request.method == 'POST': # If the form has been submitted...
        chooser = forms.ContribSelector(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            # Process the data in form.cleaned_data
            # ...
            template =  loader.get_template('ringapp/suggestions.html')
            #choice = chooser.cleaned_data['option']
            #context = RequestContext(request,{'choice':choice})
            return HttpResponse(template.render(context))
    else:
        chooser = ContribSelector() # An unbound form    
        template =  loader.get_template('ringapp/contribute.html')
        context = RequestContext(request,{'chooser':chooser})
        return HttpResponse(template.render(context))

def suggestions(request):
    template =  loader.get_template('ringapp/suggestions.html')
    context = RequestContext(request,request.GET)
    return HttpResponse(template.render(context))
