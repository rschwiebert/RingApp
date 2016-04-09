from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.contrib.auth.views import login, logout, password_reset
from django.contrib.auth.forms import UserCreationForm
from django.views.generic import TemplateView, ListView, DetailView, FormView
from django.views.generic.edit import CreateView
from ringapp import views
from ringapp import models

urlpatterns = [
    url(r'^login/$', login, {'template_name': 'ringapp/login.html'}, name='login'),
    url(r'^logout/$', logout, {'next_page': '/'}, name='logout'),
    url(r'^password_reset/$', password_reset, name='password_reset'),
    url(r'^admin/utilities/$', TemplateView.as_view(template_name='admin/utilities.html'), name='utilities'),
    url(r'^admin/guides/$', TemplateView.as_view(template_name='admin/guides.html'), name='guides'),
    url(r'^admin/processor/$', views.processor, name='processor'),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', TemplateView.as_view(template_name='ringapp/index.html'), name='index'),
    url(r'^search/$', views.searchpage, name='search'),
    url(r'^commsearch/$', views.commsearchpage, name='csearch'),
    url(r'^search/results/$', views.results, name='results'),
    url(r'^commsearch/commresults/$', views.commresults, name='cresults'),
    url(r'^rings/$', ListView.as_view(model=models.Ring), name='ring-list'),
    url(r'^commrings/$', views.CommRingList.as_view(), name='commring-list'),
    url(r'^rings/ring/(?P<ring_id>\d+)/$', views.viewring, name='ring-detail'),
    url(r'^commrings/ring/(?P<ring_id>\d+)/$', views.viewcommring, name='commring-detail'),

    url(r'^properties/$', views.PropertyList.as_view(), name='property-list'),
    url(r'^properties/property/(?P<pk>\d+)/$', views.PropertyView.as_view(), name='property-detail'),
    url(r'^commproperties/$', views.CommPropertyList.as_view(), name='commproperty-list'),
    url(r'^commproperties/property/(?P<pk>\d+)/$', views.CommPropertyView.as_view(), name='commproperty-detail'),

    url(r'^logics/$', ListView.as_view(model=models.Logic), name='logic-list'),
    url(r'^logics/logic/(?P<pk>\d+)/$', DetailView.as_view(model=models.Logic), name='logic-detail'),
    url(r'^commlogics/$', views.CommLogicList, name='commlogic-list'),
    url(r'^commlogics/commlogic/(?P<pk>\d+)/$', DetailView.as_view(model=models.CommLogic), name='commlogic-detail'),
    url(r'^theorems/$', ListView.as_view(model=models.Theorem), name='theorem-list'),
    url(r'^theorems/theorem/(?P<theorem_id>\d+)/$', views.TheoremDetail, name='theorem-detail'),
    url(r'^about/$', TemplateView.as_view(template_name='ringapp/about.html'), name='about'),
    url(r'^people/$', TemplateView.as_view(template_name='ringapp/people.html'), name='people'),
    url(r'^resources/$', TemplateView.as_view(template_name='ringapp/resources.html'), name='resources'),
    url(r'^contribute/$', views.SuggestionView.as_view(), name='contribute'),
    url(r'^suggestions/$', views.suggestions, name='suggestions'),
    url(r'^bibliography/$', views.bibliography, name='bibliography'),
    url(r'^register/$', CreateView.as_view(template_name='ringapp/register.html',
                                           form_class=UserCreationForm,
                                           success_url='profile/'), name='register'),
    url(r'^profile/$', views.ProfileView.as_view(), name='profile'),
]
