import textwrap

from django.db import models

from django.contrib.auth.models import User


class Suggestion(models.Model):
    object_type = models.SmallIntegerField(choices=[(0, 'ring'),
                                                    (1, 'citation'),
                                                    (2, 'theorem'),
                                                    (3, 'other'),
                                                    (4, 'property of a ring'),
                                                    (5, 'property'),
                                                    (6, 'feature')],
                                           )
    status = models.SmallIntegerField(choices=[(-2, 'need info'),
                                               (-1, 'declined'),
                                               (0, 'pending'),
                                               (1, 'accepted'),
                                               (2, 'withdrawn')],
                                      default=0)
    name = models.CharField(max_length=50, null=True, blank=True)
    description = models.TextField(max_length=400, null=True, blank=True)
    response = models.TextField(max_length=200, null=True, blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    unread = models.BooleanField(default=True)

    def __str__(self):
        return textwrap.shorten('[{}] {} {}'.format(self.get_object_type_display(),
                                                    self.name, self.description), width=75)

