from .common import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'POSTGRES_DB',
        'HOST': 'POSTGRES_HOST',
        'USER': 'POSTGRES_USER',
        'PASSWORD': 'POSTGRES_PASSWORD'
    }
}

MEDIA_URL = 'http://TAIGA_HOSTNAME/media/'
STATIC_URL = 'http://TAIGA_HOSTNAME/static/'

SITES["front"]["scheme"] = "http"
SITES["front"]["domain"] = 'TAIGA_HOSTNAME'

SECRET_KEY = 'TAIGA_SECRET'

DEBUG = True
PUBLIC_REGISTER_ENABLED = True

DEFAULT_FROM_EMAIL = "no-reply@example.com"
SERVER_EMAIL = DEFAULT_FROM_EMAIL

#CELERY_ENABLED = True

EVENTS_PUSH_BACKEND = "taiga.events.backends.rabbitmq.EventsPushBackend"
EVENTS_PUSH_BACKEND_OPTIONS = {"url": "amqp://RABBITMQ_DEFAULT_USER:RABBITMQ_DEFAULT_PASS@RABBITMQ_HOST:5672/RABBITMQ_DEFAULT_VHOST"}

# Uncomment and populate with proper connection parameters
# for enable email sending. EMAIL_HOST_USER should end by @domain.tld
#EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
#EMAIL_USE_TLS = False
#EMAIL_HOST = "localhost"
#EMAIL_HOST_USER = ""
#EMAIL_HOST_PASSWORD = ""
#EMAIL_PORT = 25

# Uncomment and populate with proper connection parameters
# for enable github login/singin.
#GITHUB_API_CLIENT_ID = "yourgithubclientid"
#GITHUB_API_CLIENT_SECRET = "yourgithubclientsecret"
