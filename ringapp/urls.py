from django.contrib import admin
from django.contrib.auth.forms import UserCreationForm
from django.contrib.sitemaps.views import sitemap
from django.urls import reverse_lazy, path, include, re_path
from django.http import HttpResponse
from django.shortcuts import redirect
from django.views.generic import TemplateView, RedirectView, CreateView
from ringapp import views
import web.views
from ringapp.sitemaps import sitemapdict
from ringapp.views import misfitlist

urlpatterns = [
    path('login/', RedirectView.as_view(pattern_name='auth_login', permanent=True)),
    path('logout/', RedirectView.as_view(pattern_name='auth_logout', permanent=True)),
    path('admin/utilities/', TemplateView.as_view(template_name='admin/utilities.html'), name='utilities'),
    path('admin/guides/', TemplateView.as_view(template_name='admin/guides.html'), name='guides'),
    path('admin/processor/', views.processor, name='processor'),
    path('admin/', admin.site.urls),
    path('', views.IndexView.as_view(), name='index'),

    path('search/', views.searchpage, name='search'),
    path('commsearch/', views.commsearchpage, name='csearch'),
    path('search/results/', views.resultspage, name='results'),
    path('commsearch/commresults/', views.commresultspage, name='cresults'),

    path('keywordsearch/', views.KeywordSearchPage.as_view(), name='ksearch'),
    path('keywordsearch/results/', views.KeywordSearchPage.as_view(), name='kresults'),
    path('keywords/keyword/<int:pk>/', views.KeywordDetailView.as_view(), name='keyword-detail'),

    path('rings/', views.RingList.as_view(), name='ring-list'),
    path('commrings/', views.CommRingList.as_view(), name='commring-list'),
    path('rings/ring/<int:pk>/', views.RingDetail.as_view(), name='ring-detail'),
    path('rings/ring/<int:pk>/expanded-details/', views.DetailTemplateView.as_view(), name='expanded-detail'),

    path('properties/', views.PropertyList.as_view(), name='property-list'),
    path('commproperties/', views.CommPropertyList.as_view(), name='commproperty-list'),
    path('properties/property/<int:pk>/', views.PropertyView.as_view(), name='property-detail'),

    path('dimensions/', views.DimensionView.as_view(), name='dimension-list'),

    path('theorems/', views.TheoremListView.as_view(), name='theorem-list'),
    path('theorems/theorem/<int:pk>/', views.TheoremDetail.as_view(), name='theorem-detail'),
    path('about/', TemplateView.as_view(template_name='ringapp/about.html'), name='about'),
    path('people/', TemplateView.as_view(template_name='ringapp/people.html'), name='people'),
    path('resources/', TemplateView.as_view(template_name='ringapp/resources.html'), name='resources'),
    path('contribute/', web.views.SuggestionView.as_view(), name='contribute'),
    path('contributors/', TemplateView.as_view(template_name='ringapp/contributors.html'), name='contributors'),
    path('inspiration/', views.inspiration_view, name='inspiration'),
    path('bibliography/', views.CitationList.as_view(), name='bibliography'),
    path('cite/', TemplateView.as_view(template_name='ringapp/cite.html'), name='cite'),
    path('errata/', views.ErrataList.as_view(), name='errata-list'),
    path('faq/', TemplateView.as_view(template_name='ringapp/faq.html'), name='faq'),
    path('maps/', views.ringmaplist, name='ring-maps'),
    re_path(r'^maps/(?P<filename>\w+)/$', views.svgview, name='ring-map'),

    # Must come before inclusion of registration.backends urls as it overrides one.
    path('accounts/login/', views.RatelimitedLoginView.as_view(), name='auth_login'),
    path('accounts/', include('registration.backends.default.urls')),
    path('register/', CreateView.as_view(template_name='ringapp/register.html',
                                           form_class=UserCreationForm,
                                           success_url='profile/'), name='register'),
    path('profile/', views.ProfileView.as_view(), name='profile'),

    re_path(r'^sitemap\.xml$', sitemap, {'sitemaps': sitemapdict},
        name='django.contrib.sitemaps.views.sitemap'),
    re_path(r'^robots\.txt$',
        lambda r: HttpResponse("User-agent: *\nDisallow: /search/results/"
                               "\nDisallow: /commsearch/commresults/"
                               "\nDisallow: /keywordsearch/results/"
                               "\nUser-agent: AhrefsBot"
                               "\nDisallow: /"
                               "\nUser-agent: The Knowledge AI"
                               "\nDisallow: /"
                               "\nUser-agent: SemrushBot/7~bl"
                               "\nDisallow: /"
                               "\nUser-agent: clark-crawler2/Nutch-1.19-SNAPSHOT"
                               "\nDisallow: /",
                               content_type="text/plain"),
        name='robots'),
    re_path(r'^favicon\.ico$', lambda r: redirect(r'static/favicon/favicon.ico'), name='favicon'),

    path('latest/feed/',
        RedirectView.as_view(url='https://databaseofringtheory.wordpress.com/feed/', permanent=True),
        name='newsfeed'),

    path('commproperties/property/<int:pk>/',
        views.CommPropertyRedirect.as_view(),
        name='commproperty-detail'),
    path('commrings/ring/<int:pk>/',
        RedirectView.as_view(pattern_name='ring-detail', permanent=True),
        name='commring-detail'),
    path('expanded-details/omearas-matrix-algebra/',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 80}),
                             permanent=True)),
    path('expanded-details/bergmans-exchange-ring/',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 70}),
                             permanent=True)),
    path('expanded-details/bergmans-primitive-ring/',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 31}),
                             permanent=True)),
    path('expanded-details/bergmans-right-primitive-ring/',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 73}),
                             permanent=True)),
    path('expanded-details/bergmans-unit-regular-ring/',
        RedirectView.as_view(url=reverse_lazy('expanded-detail', kwargs={'pk': 81}),
                             permanent=True)),

    path('modules/', include('moduleapp.urls')),
    path('misfits/', misfitlist, name='misfits'),

    path('notifications/unread_count/', views.live_unread_notification_count, name='live_unread_notification_count'),
    re_path(r'^notifications/toggle_read/', views.toggle_read, name='toggle_read_flag'),
]
