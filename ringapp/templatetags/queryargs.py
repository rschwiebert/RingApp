from django import template

register = template.Library()


@register.filter
def update_symmfilter(request, arg):
    query_dict = request.GET.copy()
    query_dict['symmsort'] = arg
    return query_dict.urlencode()\

@register.filter
def update_asymmfilter(request, arg):
    query_dict = request.GET.copy()
    query_dict['asymmsort'] = arg
    return query_dict.urlencode()
