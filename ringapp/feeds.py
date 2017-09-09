from django.contrib.syndication.views import Feed
from django.core.urlresolvers import reverse
from ringapp.models import News


class NewsFeed(Feed):
    title = 'DaRT news'
    link = '/news/'
    description = 'A feed of the latest news announcements on the site.'
    item_author_name  = 'R. C. Schwiebert'

    def items(self):
        return News.objects.order_by('-id')[:20]

    def item_link(self, item):
        return reverse('news-detail', args=[item.id])

    def item_title(self, item):
        return item.title

    def item_pubdate(self, item):
        return item.timestamp

    def item_categories(self, item):
        if item.category:
            return item.category.split(',')
        else:
            return None
