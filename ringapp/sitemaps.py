from django.contrib.sitemaps import Sitemap
from ringapp.models import Ring, Property, CommProperty, Theorem

from django.core.urlresolvers import reverse

class StaticViewSitemap(Sitemap):
    priority = 0.5
    changefreq = 'weekly'

    def items(self):
        return ['index', 'search', 'csearch', 'about', 
                'resources', 'contribute', 'ring-list', 'commring-list',
                'property-list', 'commproperty-list', 'theorem-list']

    def location(self, item):
        return reverse(item)


class RingMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return Ring.objects.all()
    
    def location(self, obj):
        return reverse('ring-detail', kwargs={"ring_id": obj.ring_id})


class CommRingMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return Ring.objects.filter(ringproperty__property=Property.objects.get(pk=1),
                                   ringproperty__has_property=1)
    
    def location(self, obj):
        return reverse('commring-detail', kwargs={"ring_id": obj.ring_id})


class PropertyMap(Sitemap):
    changefreq = "monthly"
    priority = 0.5

    def items(self):
        return Property.objects.all()
    
    def location(self, obj):
        return reverse('property-detail', kwargs={"pk": obj.property_id})

    
class CommPropertyMap(Sitemap):
    changefreq = "monthly"
    priority = 0.5

    def items(self):
        return CommProperty.objects.all()
    
    def location(self, obj):
        return reverse('commproperty-detail', kwargs={"pk": obj.property_id})


class TheoremMap(Sitemap):
    changefreq = "weekly"
    priority = 0.5

    def items(self):
        return Theorem.objects.all()
    
    def location(self, obj):
        return reverse('theorem-detail', kwargs={"pk": obj.theorem_id})


sitemapdict = {'rings': RingMap, 'commrings': CommRingMap,
               'properties': PropertyMap, 'commproperties': CommPropertyMap,
               'theorems': TheoremMap,
               'static': StaticViewSitemap,}
