#!/bin/bash
DESTINATION=$1
PORT=$2
CHAT=$3
MASTERPASSWORD=$4
# clonar directorio Odoo
git clone --depth=1 https://github.com/JorgeGijon/Instalar_Odoo_Docker_Compose $DESTINATION
rm -rf $DESTINATION/.git
# set permission
mkdir -p $DESTINATION/postgresql
sudo chmod -R 777 $DESTINATION

# config
if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi
sudo sysctl -p
sed -i 's/10001/'$PORT'/g' $DESTINATION/docker-compose_v18.yml
sed -i 's/20001/'$CHAT'/g' $DESTINATION/docker-compose_v18.yml
# correr Odoo
docker-compose -f $DESTINATION/docker-compose_v18.yml up -d

echo 'Started Odoo @ http://localhost:'$PORT' | Master Password: '$MASTERPASSWORD' | Live chat port: '$CHAT

# cambiar master password por defecto
sudo sed -i 's/pass.por.defecto/'$MASTERPASSWORD'/g' "/home/ubuntu/"$DESTINATION"/etc/odoo.conf"
