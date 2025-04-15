from django.contrib.sitemaps import Sitemap
from django.urls import reverse

from moduleapp import models as modulemodels
from ringapp import models as ringmodels


class StaticViewSitemap(Sitemap):
    changefreq = 'weekly'
    priority = 0.5

    def items(self):
        return ['index', 'search', 'csearch', 'ksearch', 'about', 'faq',
                'resources', 'contribute', 'ring-list', 'commring-list',
                'property-list', 'theorem-list', 'errata-list', 'dimension-list',
                'module-list', 'module-property-list', 'module-search',
                'misfits', 'ring-maps']

    def location(self, item):
        return reverse(item)


class RingMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return ringmodels.Ring.objects.all()

    def location(self, obj):
        return reverse('ring-detail', kwargs={"pk": obj.id})


class CommRingMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return ringmodels.Ring.objects.filter(is_commutative=True)

    def location(self, obj):
        return reverse('ring-detail', kwargs={"pk": obj.id})


class RingPropertyMap(Sitemap):
    changefreq = "monthly"
    priority = 0.5

    def items(self):
        return ringmodels.Property.objects.all()

    def location(self, obj):
        return reverse('property-detail', kwargs={"pk": obj.id})


class ModuleMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return modulemodels.Module.objects.all()

    def location(self, obj):
        return reverse('module-detail', kwargs={"pk": obj.id})


class ModulePropertyMap(Sitemap):
    changefreq = "monthly"
    priority = 0.5

    def items(self):
        return modulemodels.Property.objects.all()

    def location(self, obj):
        return reverse('module-property-detail', kwargs={"pk": obj.id})


class TheoremMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return ringmodels.Theorem.objects.all()

    def location(self, obj):
        return reverse('theorem-detail', kwargs={"pk": obj.id})


sitemapdict = {'rings': RingMap, 'commrings': CommRingMap,
               'properties': RingPropertyMap,
               'modules': ModuleMap,
               'module-properties': ModulePropertyMap,
               'theorems': TheoremMap,
               'static': StaticViewSitemap}
