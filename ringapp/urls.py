from django.conf.urls import include, url
from django.contrib import admin
from django.contrib.auth.forms import UserCreationForm
from django.contrib.sitemaps.views import sitemap
from django.core.urlresolvers import reverse_lazy
from django.http import HttpResponse
from django.shortcuts import redirect
from django.views.generic import TemplateView, ListView, RedirectView, CreateView
from ringapp import views
from ringapp import models
from ringapp.feeds import NewsFeed
from ringapp.sitemaps import sitemapdict


urlpatterns = [
    url(r'^login/$', RedirectView.as_view(pattern_name='auth_login', permanent=True)),
    url(r'^logout/$', RedirectView.as_view(pattern_name='auth_logout', permanent=True)),
    url(r'^admin/utilities/$', TemplateView.as_view(template_name='admin/utilities.html'), name='utilities'),
    url(r'^admin/guides/$', TemplateView.as_view(template_name='admin/guides.html'), name='guides'),
    url(r'^admin/processor/$', views.processor, name='processor'),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', views.IndexView.as_view(), name='index'),

    url(r'^search/$', views.searchpage, name='search'),
    url(r'^commsearch/$', views.commsearchpage, name='csearch'),
    url(r'^search/results/$', views.resultspage, name='results'),
    url(r'^commsearch/commresults/$', views.commresultspage, name='cresults'),

    url(r'^keywordsearch/$', views.KeywordSearchPage.as_view(), name='ksearch'),
    url(r'^keywordsearch/results/$', views.KeywordSearchPage.as_view(), name='kresults'),
    url(r'^keywords/keyword/(?P<pk>\d+)/$', views.KeywordDetailView.as_view(), name='keyword-detail'),

    url(r'^rings/$', views.RingList.as_view(), name='ring-list'),
    url(r'^commrings/$', views.CommRingList.as_view(), name='commring-list'),
    url(r'^rings/ring/(?P<pk>\d+)/$', views.RingDetail.as_view(), name='ring-detail'),
    url(r'^rings/ring/(?P<pk>\d+)/expanded-details/$', views.DetailTemplateView.as_view(), name='expanded-detail'),

    url(r'^properties/$', views.PropertyList.as_view(), name='property-list'),
    url(r'^properties/property/(?P<pk>\d+)/$', views.PropertyView.as_view(), name='property-detail'),

    # url(r'^logics/$', ListView.as_view(model=models.Logic), name='logic-list'),
    # url(r'^logics/logic/(?P<pk>\d+)/$', DetailView.as_view(model=models.Logic), name='logic-detail'),
    url(r'^dimensions/$', views.DimensionView.as_view(), name='dimension-list'),

    url(r'^theorems/$', ListView.as_view(model=models.Theorem), name='theorem-list'),
    url(r'^theorems/theorem/(?P<pk>\d+)/$', views.TheoremDetail.as_view(), name='theorem-detail'),
    url(r'^about/$', TemplateView.as_view(template_name='ringapp/about.html'), name='about'),
    url(r'^people/$', TemplateView.as_view(template_name='ringapp/people.html'), name='people'),
    url(r'^resources/$', TemplateView.as_view(template_name='ringapp/resources.html'), name='resources'),
    url(r'^contribute/$', views.SuggestionView.as_view(), name='contribute'),
    url(r'^inspiration/$', views.inspiration_view, name='inspiration'),
    url(r'^bibliography/$', views.CitationList.as_view(), name='bibliography'),
    url(r'^cite/$', views.citeview, name='cite'),
    url(r'^errata/$', views.ErrataList.as_view(), name='errata-list'),

    # Must come before inclusion of registration.backends urls as it overrides one.
    url(r'^accounts/login/$', views.RatelimitedLoginView.as_view(), name='auth_login'),
    url(r'^accounts/', include('registration.backends.default.urls')),
    url(r'^register/$', CreateView.as_view(template_name='ringapp/register.html',
                                           form_class=UserCreationForm,
                                           success_url='profile/'), name='register'),
    url(r'^profile/$', views.ProfileView.as_view(), name='profile'),

    url(r'^sitemap\.xml$', sitemap, {'sitemaps': sitemapdict},
        name='django.contrib.sitemaps.views.sitemap'),
    url(r'^robots\.txt$',
        lambda r: HttpResponse("User-agent: *\nDisallow: /search/results/"
                               "\nDisallow: /commsearch/commresults/"
                               "\nDisallow: /keywordsearch/results/"
                               "\nUser-agent: AhrefsBot"
                               "\nDisallow: /",
                               content_type="text/plain"),
        name='robots'),
    url(r'^favicon\.ico$', lambda r: redirect(r'static/favicon/favicon.ico'), name='favicon'),

    url(r'^latest/feed/$', NewsFeed(), name='newsfeed'),
    url(r'^news/$', views.NewsList.as_view(), name='news-list'),
    url(r'^news/(?P<pk>\d+)/$', views.NewsDetail.as_view(), name='news-detail'),

    url(r'^commproperties/$',
        RedirectView.as_view(pattern_name='property-list', permanent=True),
        name='commproperty-list'),
    url(r'^commproperties/property/(?P<pk>\d+)/$',
        views.CommPropertyRedirect.as_view(),
        name='commproperty-detail'),
    url(r'^commrings/ring/(?P<pk>\d+)/$',
        RedirectView.as_view(pattern_name='ring-detail', permanent=True),
        name='commring-detail'),
    url(r'^expanded-details/omearas-matrix-algebra/$',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 80}),
                             permanent=True)),
    url(r'^expanded-details/bergmans-exchange-ring/$',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 70}),
                             permanent=True)),
    url(r'^expanded-details/bergmans-primitive-ring/$',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 31}),
                             permanent=True)),
    url(r'^expanded-details/bergmans-right-primitive-ring/$',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 73}),
                             permanent=True)),
    url(r'^expanded-details/bergmans-unit-regular-ring/$',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 81}),
                             permanent=True)),
    url(r'^notifications/unread_count/$', views.live_unread_notification_count, name='live_unread_notification_count'),
    url(r'^notifications/toggle_read/', views.toggle_read, name='toggle_read_flag'),
]
