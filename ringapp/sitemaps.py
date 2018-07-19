from django.contrib.sitemaps import Sitemap
from django.core.urlresolvers import reverse
from ringapp.models import Ring, Property, Theorem


class StaticViewSitemap(Sitemap):
    changefreq = 'weekly'
    priority = 0.5

    def items(self):
        return ['index', 'search', 'csearch', 'ksearch', 'about',  'faq',
                'resources', 'contribute', 'ring-list', 'commring-list',
                'property-list', 'theorem-list', 'errata-list', 'dimension-list']

    def location(self, item):
        return reverse(item)


class RingMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return Ring.objects.all()
    
    def location(self, obj):
        return reverse('ring-detail', kwargs={"pk": obj.id})


class CommRingMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return Ring.objects.filter(is_commutative=True)
    
    def location(self, obj):
        return reverse('ring-detail', kwargs={"pk": obj.id})


class PropertyMap(Sitemap):
    changefreq = "monthly"
    priority = 0.5

    def items(self):
        return Property.objects.all()
    
    def location(self, obj):
        return reverse('property-detail', kwargs={"pk": obj.id})


class TheoremMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return Theorem.objects.all()
    
    def location(self, obj):
        return reverse('theorem-detail', kwargs={"pk": obj.id})


sitemapdict = {'rings': RingMap, 'commrings': CommRingMap,
               'properties': PropertyMap,
               'theorems': TheoremMap,
               'static': StaticViewSitemap}
