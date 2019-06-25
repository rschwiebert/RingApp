from django.core.management.base import BaseCommand, CommandError
from ringapp.models import Ring
from ringapp.LogicUtils import LogicEngine


class Command(BaseCommand):
    help = 'Session you can use to process rings'

    def handle(self, *args, **options):
        log_eng = LogicEngine()
        while True:
            c = input("Enter ring id or 'q'")
            if c == 'q':
                print('exiting')
                return
            elif c.isdigit():
                ring = Ring.objects.get(pk=c)
                n = input('how many iterations?')
                for i in range(int(n)):
                    log_eng.process_ring(ring)
