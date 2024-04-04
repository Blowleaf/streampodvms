#!/bin/bash
set -e

# forward request and error logs to docker log collector
ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log && \
ln -sf /dev/stdout /var/log/nginx/streampod.io.access.log && ln -sf /dev/stderr /var/log/nginx/streampod.io.error.log

cp /home/streampod.io/streampod/deploy/docker/local_settings.py /home/streampod.io/streampod/cms/local_settings.py

mkdir -p /home/streampod.io/streampod/{logs,plugins,media_files/hls}
touch /home/streampod.io/streampod/logs/debug.log

mkdir -p /var/run/streampod
chown www-data:www-data /var/run/streampod # 20231030 changed for test - ocano

TARGET_GID=$(stat -c "%g" /home/streampod.io/streampod/)

EXISTS=$(cat /etc/group | grep $TARGET_GID | wc -l)

# Create new group using target GID and add www-data user
if [ $EXISTS == "0" ]; then
    groupadd -g $TARGET_GID tempgroup
    usermod -a -G tempgroup www-data
else
    # GID exists, find group name and add
    GROUP=$(getent group $TARGET_GID | cut -d: -f1)
    usermod -a -G $GROUP www-data
fi

# 20231030 changed for test - ocano
# We should do this only for folders that have a different owner, since it is an expensive operation
## find /home/mediacms.io/ ! \( -user www-data -group $TARGET_GID \) -exec chown www-data:$TARGET_GID {} + 

## chmod +x /home/mediacms.io/mediacms/deploy/docker/start.sh /home/mediacms.io/mediacms/deploy/docker/prestart.sh
# 20231030 changed for test - ocano
exec "$@"
