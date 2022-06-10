from django.urls import reverse_lazy, path, include, re_path
from django.http import HttpResponse
from django.shortcuts import redirect
from django.views.generic import TemplateView, RedirectView, CreateView

from moduleapp import views

urlpatterns = [

    path('search', views.searchpage, name='module-search'),
    path('search/results/', views.resultspage, name='module-results'),

    # path('keywordsearch/', views.KeywordSearchPage.as_view(), name='ksearch'),
    # path('keywordsearch/results/', views.KeywordSearchPage.as_view(), name='kresults'),
    # path('keywords/keyword/<int:pk>/', views.KeywordDetailView.as_view(), name='keyword-detail'),

    path('', views.ModuleList.as_view(), name='module-list'),
    path('<int:pk>/', views.ModuleDetail.as_view(), name='module-detail'),
    # path('rings/ring/<int:pk>/expanded-details/', views.DetailTemplateView.as_view(), name='expanded-detail'),

    path('properties/', views.PropertyList.as_view(), name='module-property-list'),
    path('properties/<int:pk>/', views.PropertyView.as_view(), name='module-property-detail'),

    # path('dimensions/', views.DimensionView.as_view(), name='dimension-list'),
]