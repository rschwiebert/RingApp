class RingAppRouter(object):

    def db_for_read(self, model, **hints):
        if model._meta.app_label == 'ringapp':
            return 'ringapp_data'

        elif model._meta.app_label == 'publications':
            return 'ringapp_data'

        else:
            return 'default'

    def db_for_write(self, model, **hints):
        if model._meta.app_label == 'ringapp':
            return 'ringapp_data'

        elif model._meta.app_label == 'publications':
            return 'ringapp_data'

        else:
            return 'default'

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        # This is the only model from ringapp to remain in the 'default' database
        # after the split. Unfortunately we need this exception.
        if model_name == 'suggestion' and db == 'default':
            return True

        elif app_label in ('ringapp', 'publications'):
            if db == 'ringapp_data':
                return True
            else:
                return False

        else:
            if db in 'default':
                return True
            else:
                return False
