"""
Django settings for ringapp project.

Generated by 'django-admin startproject' using Django 1.11.6.

For more information on this file, see
https://docs.djangoproject.com/en/1.11/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.11/ref/settings/
"""

import os
import boto3
import django_heroku

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.makedirs(os.path.join(BASE_DIR, 'db'), exist_ok=True)
SQLITE_PATH = os.path.join(BASE_DIR, 'db', 'ringapp.db')

if not os.path.exists(SQLITE_PATH):
    os.makedirs(os.path.dirname(SQLITE_PATH), exist_ok=True)
    s3 = boto3.client('s3')
    with open(SQLITE_PATH, 'wb') as f:
        s3.download_fileobj(os.environ['S3_BUCKET_NAME'], 'ringapp.db', f)

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.11/howto/deployment/checklist/

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

LOGIN_URL = '/login'
LOGIN_REDIRECT_URL = '/profile'

# Application definition

INSTALLED_APPS = [
    'ringapp',
    'web',
    'dart_data',
    'registration',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'django.contrib.sitemaps',
    'mathfilters',
    'publications',
    'captcha',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'ratelimit.middleware.RatelimitMiddleware',
]

RATELIMIT_VIEW = 'ringapp.views.ratelimited_view'

ROOT_URLCONF = 'ringapp.urls'
SITE_ID = 1

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'ringapp.wsgi.application'

# Password validation
# https://docs.djangoproject.com/en/1.11/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
# https://docs.djangoproject.com/en/1.11/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True

# Email settings
SENDGRID_API_KEY = os.getenv('SENDGRID_API_KEY')
EMAIL_HOST = os.environ['EMAIL_HOST']
EMAIL_PORT = os.environ['EMAIL_PORT']
EMAIL_HOST_USER = 'apikey'
EMAIL_HOST_PASSWORD = SENDGRID_API_KEY
EMAIL_USE_TLS = True

# Registration-redux specific settings
ACCOUNT_ACTIVATION_DAYS = 2
REGISTRATION_DEFAULT_FROM_EMAIL = os.environ['REGISTRATION_DEFAULT_FROM_EMAIL']
REGISTRATION_FORM = 'registration.forms.RegistrationFormUniqueEmail'

# Recaptcha settings
NOCAPTCHA = True
RECAPTCHA_PUBLIC_KEY = os.environ['RECAPTCHA_PUBLIC_KEY']
RECAPTCHA_PRIVATE_KEY = os.environ['RECAPTCHA_PRIVATE_KEY']

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'TIMEOUT': None
    }
}

ADMINS = [('webmaster', os.environ['REGISTRATION_DEFAULT_FROM_EMAIL'])]

DATABASES = {
    'default': {
        'ATOMIC_REQUESTS': False,
        'AUTOCOMMIT': True,
        'CONN_MAX_AGE': 600,
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'HOST': 'localhost',
        'NAME': 'ringapp',
        'OPTIONS': {'sslmode': 'disable'},
        'PASSWORD': 'ringapp',
        'PORT': 5432,
        'TEST': {'CHARSET': None,
                 'COLLATION': None,
                 'MIRROR': None,
                 'NAME': None},
        'TIME_ZONE': None,
        'USER': 'ringapp'},
    'ringapp_data': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db/ringapp.db')},
}

DATABASE_ROUTERS = ('ringapp.routers.RingAppRouter',)

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'simple': {
            'format': '[%(levelname)s %(name)s] %(message)s'
        },
    },
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
            'formatter': 'simple'
        },
        'mail_admins': {
            'level': 'ERROR',
            'class': 'django.utils.log.AdminEmailHandler',
        }
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': os.getenv('DJANGO_LOG_LEVEL', 'INFO'),
            'propagate': False,
        },
        'ringapp': {
            'handlers': ['console'],
            'level': os.getenv('DJANGO_LOG_LEVEL', 'INFO'),
        },
        '': {
            'handlers': ['console', 'mail_admins'],
            'level': os.getenv('DJANGO_LOG_LEVEL', 'ERROR'),
        },
    },
}

# Configure Django App for Heroku.
django_heroku.settings(locals(), logging=False)

DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'

# For use with the db_to_data import/export management command
EXPORT_ROOT_DIR = os.environ.get('EXPORT_ROOT_DIR')

# To redirect http to https in production
SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
