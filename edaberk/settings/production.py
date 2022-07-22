from .base import *

DEBUG = False

# SECURITY WARNING: define the correct hosts in production!
ALLOWED_HOSTS = ["188.166.160.83"]

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql_psycopg2",
        "NAME": os.environ["DB_NAME"],
        "USER": os.environ["DB_USER"],
        "PASSWORD": os.environ["DB_PASSWORD"],
        "HOST": "127.0.0.1",
        "PORT": "5432",
    }
}

try:
    from .local import *
except ImportError:
    pass
