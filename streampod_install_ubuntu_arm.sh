#!/bin/bash
## Ubuntu AWS Flow: 
# sudo mkdir /home/streampod.io && cd /home/streampod.io/
# sudo git clone -b ec2-ubuntu https://github.com/Blowleaf/streampodvms 
# sudo mv streampodvms streampod 
# sudo cd /home/streampod.io/streampod/ && bash ./streampod_install_ubuntu_arm.sh
# source  /home/streampod.io/bin/activate
# press enter on localhost and portal name. 
# make .env
# sudo apt-get update && apt-get -y ugrade && 
# sudo apt-get install python-is-python3 python3-pip python3-venv python3-dev python3-virtualenv python-is-python3 -y
# 'Create python virtualenv on /home/streampod.io'
# cd /home/streampod.io
# sudo virtualenv . --python=python3
# sudo bash ./streampod_install_ubuntu_arm.sh
#  sudo su -
# sudo passwd postgres
# postgres-#  \d

# should be run as root and only on Ubuntu 20/22/24, Debian 10/11 (Buster/Bullseye) versions!
echo "Welcome to the StreamPod installation!";

if [ `id -u` -ne 0 ]
  then echo "Please run as root"
  exit
fi


while true; do
    read -p "
This script will attempt to perform a system update, install required dependencies, install and configure PostgreSQL, NGINX, Redis and a few other utilities.
It is expected to run on a new system **with no running instances of any these services**. Make sure you check the script before you continue. Then enter yes or no
" yn
    case $yn in
        [Yy]* ) echo "OK!"; break;;
        [Nn]* ) echo "Have a great day"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


osVersion=$(lsb_release -d)
if [[ $osVersion == *"Ubuntu 24"* ]] || [[ $osVersion == *"Ubuntu 22"* ]] ||  [[ $osVersion == *"Ubuntu 20"* ]] || [[ $osVersion == *"buster"* ]] || [[ $osVersion == *"bullseye"* ]]; then
    echo 'Performing system update and dependency installation, this will take a few minutes'
    sudo apt-get update && apt-get -y upgrade && apt-get install uwsgi redis-server postgresql nginx git gcc vim unzip imagemagick python3-certbot-nginx certbot wget xz-utils -y
    sudo snap install aws-cli --classic
else
    echo "This script is tested for Ubuntu 20/22/24 versions only, if you want to try StreamPod on another system you have to perform the manual installation"
    exit
fi

# install ffmpeg
echo "Downloading and installing ffmpeg"
wget -q https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-arm64-static.tar.xz
mkdir -p tmp
tar -xf ffmpeg-release-arm64-static.tar.xz --strip-components 1 -C tmp
cp -v tmp/{ffmpeg,ffprobe,qt-faststart} /usr/local/bin
rm -rf tmp ffmpeg-release-arm64-static.tar.xz
echo "ffmpeg installed to /usr/local/bin"

read -p "Enter portal URL, or press enter for localhost : " FRONTEND_HOST
read -p "Enter portal name, or press enter for 'StreamPod : " PORTAL_NAME

[ -z "$PORTAL_NAME" ] && PORTAL_NAME='StreamPod'
[ -z "$FRONTEND_HOST" ] && FRONTEND_HOST='localhost'

echo 'Creating database to be used in StreamPod'

su -c "psql -c \"CREATE DATABASE streampod\"" postgres
su -c "psql -c \"CREATE USER streampod WITH ENCRYPTED PASSWORD 'streampod'\"" postgres
su -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE streampod TO streampod\"" postgres

echo 'Activating virtualenv'

cd /home/streampod.io
source /home/streampod.io/bin/activate
cd streampod
pip install -r requirements.txt

SECRET_KEY=`python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'`

# remove http or https prefix
FRONTEND_HOST=`echo "$FRONTEND_HOST" | sed -r 's/http:\/\///g'`
FRONTEND_HOST=`echo "$FRONTEND_HOST" | sed -r 's/https:\/\///g'`

sed -i s/localhost/$FRONTEND_HOST/g deploy/local_install/streampod.io

FRONTEND_HOST_HTTP_PREFIX='http://'$FRONTEND_HOST

echo 'FRONTEND_HOST='\'"$FRONTEND_HOST_HTTP_PREFIX"\' >> cms/local_settings.py
echo 'PORTAL_NAME='\'"$PORTAL_NAME"\' >> cms/local_settings.py
echo "SSL_FRONTEND_HOST = FRONTEND_HOST.replace('http', 'https')" >> cms/local_settings.py

echo 'SECRET_KEY='\'"$SECRET_KEY"\' >> cms/local_settings.py
echo "LOCAL_INSTALL = True" >> cms/local_settings.py

mkdir logs
mkdir pids
python manage.py migrate
python manage.py loaddata fixtures/encoding_profiles.json
python manage.py loaddata fixtures/categories.json
python manage.py collectstatic --noinput

ADMIN_PASS=`python -c "import secrets;chars = 'abcdefghijklmnopqrstuvwxyz0123456789';print(''.join(secrets.choice(chars) for i in range(10)))"`
echo "from users.models import User; User.objects.create_superuser('admin', 'admin@example.com', '$ADMIN_PASS')" | python manage.py shell

echo "from django.contrib.sites.models import Site; Site.objects.update(name='$FRONTEND_HOST', domain='$FRONTEND_HOST')" | python manage.py shell

chown -R www-data: /home/streampod.io/
cp deploy/local_install/celery_long.service /etc/systemd/system/celery_long.service && systemctl enable celery_long && systemctl start celery_long
cp deploy/local_install/celery_short.service /etc/systemd/system/celery_short.service && systemctl enable celery_short && systemctl start celery_short
cp deploy/local_install/celery_beat.service /etc/systemd/system/celery_beat.service && systemctl enable celery_beat &&systemctl start celery_beat
cp deploy/local_install/streampod.service /etc/systemd/system/streampod.service && systemctl enable streampod.service && systemctl start streampod.service

mkdir -p /etc/letsencrypt/live/streampod.io/
mkdir -p /etc/letsencrypt/live/$FRONTEND_HOST
mkdir -p /etc/nginx/sites-enabled
mkdir -p /etc/nginx/sites-available
mkdir -p /etc/nginx/dhparams/
rm -rf /etc/nginx/conf.d/default.conf
rm -rf /etc/nginx/sites-enabled/default
cp deploy/local_install/streampod.io_fullchain.pem /etc/letsencrypt/live/$FRONTEND_HOST/fullchain.pem
cp deploy/local_install/streampod.io_privkey.pem /etc/letsencrypt/live/$FRONTEND_HOST/privkey.pem
cp deploy/local_install/dhparams.pem /etc/nginx/dhparams/dhparams.pem
cp deploy/local_install/streampod.io /etc/nginx/sites-available/streampod.io
ln -s /etc/nginx/sites-available/streampod.io /etc/nginx/sites-enabled/streampod.io
cp deploy/local_install/uwsgi_params /etc/nginx/sites-enabled/uwsgi_params
cp deploy/local_install/nginx.conf /etc/nginx/
systemctl stop nginx
systemctl start nginx

# attempt to get a valid certificate for specified domain

if [ "$FRONTEND_HOST" != "localhost" ]; then
    echo 'attempt to get a valid certificate for specified url $FRONTEND_HOST'
    certbot --nginx -n --agree-tos --register-unsafely-without-email -d $FRONTEND_HOST
    certbot --nginx -n --agree-tos --register-unsafely-without-email -d $FRONTEND_HOST
    # unfortunately for some reason it needs to be run two times in order to create the entries
    # and directory structure!!!
    systemctl restart nginx
else
    echo "will not call certbot utility to update ssl certificate for url 'localhost', using default ssl certificate"
fi

# Generate individual DH params
if [ "$FRONTEND_HOST" != "localhost" ]; then
    # Only generate new DH params when using "real" certificates.
    openssl dhparam -out /etc/nginx/dhparams/dhparams.pem 4096
    systemctl restart nginx
else
    echo "will not generate new DH params for url 'localhost', using default DH params"
fi

# Bento4 utility installation, for HLS

# Install ARM optimized Bento4 to PATH
sudo wget https://www.deb-multimedia.org/pool/main/b/bento4-dmo/bento4_1.6.0.640-dmo1_arm64.deb
sudo apt-get install -y ./bento4_1.6.0.640-dmo1_arm64.deb
sudo rm ./bento4_1.6.0.640-dmo1_arm64.deb

# last, set default owner
chown -R www-data: /home/streampod.io/

echo 'StreamPod installation completed, open browser on http://'"$FRONTEND_HOST"' and login with user admin and password '"$ADMIN_PASS"''