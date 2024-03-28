FRONTEND_HOST = 'http://localhost'
PORTAL_NAME = 'StreamPod'
SECRET_KEY = '{SECRET_KEY}'
POSTGRES_HOST = 'db'
REDIS_LOCATION = "redis://redis:6379/1"

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "streampod",
        "HOST": POSTGRES_HOST,
        "PORT": "5432",
        "USER": "streampod",
        "PASSWORD": "streampod",
    }
}

CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": REDIS_LOCATION,
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        },
    }
}

# CELERY STUFF
BROKER_URL = REDIS_LOCATION
CELERY_RESULT_BACKEND = BROKER_URL

MP4HLS_COMMAND = "/home/streampod.io/bento4/bin/mp4hls"
MP4DASH_COMMAND = "/home/streampod.io/bento4/bin/mp4dash"
MP4INFO_COMMAND = "/home/streampod.io/bento4/bin/mp4info"

DEBUG = False
