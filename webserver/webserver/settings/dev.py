from webserver.settings.base import *

assert SERVICE_ENVIRONMENT in ('dev', 'local'), SERVICE_ENVIRONMENT

DEBUG = True

INSTALLED_APPS += ['debug_toolbar']
MIDDLEWARE += ['debug_toolbar.middleware.DebugToolbarMiddleware']
