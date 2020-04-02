"""
Django settings for webserver project.

Generated by 'django-admin startproject' using Django 3.0.4.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.0/ref/settings/
"""

import os

SERVICE_ENVIRONMENT = os.environ['SERVICE_ENVIRONMENT']

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
# /code/
BASE_DIR = os.path.dirname(
    os.path.dirname(
        os.path.dirname(
            os.path.abspath(__file__)
        )
    )
)


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ['DJANGO_SECRET_KEY']

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = (SERVICE_ENVIRONMENT in ('local', 'dev', 'stage'))

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'demo'
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'webserver.urls'


TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'templates')
        ],
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

WSGI_APPLICATION = 'webserver.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.0/ref/settings/#databases


DATABASES = {
    'default': {},

    # TODO: for project choose a database backend

    'db-sqlite': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.environ['SQLITE_FILEPATH'],
        'HOST': '',
        'USER': '',
        'PASSWORD': '',
        'PORT': '5432',
    },

    'db-postgres': {
        'ENGINE': 'django.db.backends.postgresql',
        'HOST': os.environ['POSTGRES_HOST'],
        'NAME': os.environ['POSTGRES_DB'],
        'USER': os.environ['POSTGRES_USER'],
        'PASSWORD': os.environ['POSTGRES_PASSWORD'],
        'PORT': '5432',
    },

    'db-sql-server': {
        'ENGINE': 'sql_server.pyodbc',
        # 'HOST': 'MochanCmsDB-local',  # FreeTDS Reference
        'HOST': os.environ['MSSQL_HOST'],
        'NAME': os.environ['MSSQL_DATABASE_NAME'],
        'USER': os.environ['MSSQL_USER'],
        'PASSWORD': os.environ['MSSQL_PASSWORD'],
        'PORT': '1433',
        'OPTIONS': {
            # from /etc/odbcinst.ini
            'driver': 'ODBC Driver 17 for SQL Server'
        }
    }
}

# TODO: for project choose a database backend, pick that as default
DEMO_CHOOSE_DATABASE_DEFAULT = os.environ['DEMO_CHOOSE_DATABASE_DEFAULT']
DATABASES['default'] = DATABASES[DEMO_CHOOSE_DATABASE_DEFAULT]

# Password validation
# https://docs.djangoproject.com/en/3.0/ref/settings/#auth-password-validators

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
# https://docs.djangoproject.com/en/3.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.0/howto/static-files/

STATIC_URL = '/static/'


# Logging

# 0 (show all) < debug < info < warning < error > critical < NOSET
LOGGING_LEVEL = os.enviorn.get('DJANGO_LOGGING_LEVEL', 'DEBUG')
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': (
                '{asctime} {process} {module:10}:L{lineno} '
                '{levelname:8} \n {message}'
            ),
            'style': '{'
        },
        'default': {
            'format': '{levelname} | {message}',
            'style': '{'
        }
    },
    'handlers': {
        'console': {
            'level': LOGGING_LEVEL,
            'class': 'logging.StreamHandler',
            'formatter': 'default',
        }
    },
    'root': {
        'level': LOGGING_LEVEL,
        'handlers': ['console']
    },
    'loggers': {
        'webserver': {
            'handlers': ['console'],
            'level': LOGGING_LEVEL,
        }
    }
}
