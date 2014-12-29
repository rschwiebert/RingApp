from django.conf.urls import patterns, include, url
from django.contrib import admin
from ringapp import views

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'ringapp.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', views.index, name='index'),
    url(r'^search/$', views.searchpage, name='search'),
    url(r'^commsearch/$', views.commsearchpage, name='csearch'),
    url(r'^search/results/$', views.results, name='results'),
    url(r'^commsearch/commresults/$', views.commresults, name='cresults'),
    url(r'^rings/$', views.browserings, name='rings'),
    url(r'^commrings/$', views.browsecommrings, name='crings'),
    url(r'^rings/ring/(?P<ring_id>\d+)/$', views.viewring, name='ring'),
    url(r'^commrings/ring/(?P<ring_id>\d+)/$', views.viewcommring, name='cring'),
    url(r'^properties/$', views.browseprops, name='properties'),
    url(r'^properties/property/(?P<property_id>\d+)/$', views.viewprop, name='property'),
    url(r'^commproperties/$', views.browsecommprops, name='cproperties'),
    url(r'^commproperties/property/(?P<property_id>\d+)/$', views.viewcommprop, name='cproperty'),
    url(r'^logics/$', views.browselogic, name='logics'),
    url(r'^logics/logic/(?P<logic_id>\d+)/$', views.viewlogic, name='logic'),
    url(r'^commlogics/$', views.browsecommlogic, name='commlogics'),
    url(r'^commlogics/logic/(?P<logic_id>\d+)/$', views.viewlogic, name='commlogic'),
    url(r'^about/$', views.about, name='about'),
    url(r'^people/$', views.people, name='people'),
    url(r'^resources/$', views.resources, name='resources'),
    url(r'^contribute/$', views.contribute, name='contribute'),
    url(r'^suggestions/$', views.suggestions, name='suggestions'),
)
