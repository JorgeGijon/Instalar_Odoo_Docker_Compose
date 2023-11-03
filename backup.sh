#!/bin/bash
ID_CONTENEDOR=$1

# Configuración de la base de datos PostgreSQL
PG_HOST=db                                          #nombre_del_contenedor_postgres
PG_DATABASE=postgres                                #nombre_de_la_base_de_datos
PG_USER=odoo                                        #nombre_de_usuario
PG_PATH=/home/ubuntu/copias_seguridad               #ruta local donde colocar carpeta backups
ID_CONTENEDOR=e897                                  #nombre contenedor o id del docker postgresql (sirven 4 dig)
BACKUP_FILE=backup_$(date +"%Y-%m-%d_%H-%M-%S").sql

# Realizar la copia de seguridad utilizando pg_dump
#sudo docker exec -it e897 /bin/bash
#sudo docker ps
sudo mkdir /home/ubuntu/copias_seguridad
sudo chmod 777 /home/ubuntu/copias_seguridad
sudo docker exec -it e897 pg_dump -U $PG_USER $PG_DATABASE > $PG_PATH/$BACKUP_FILE
sudo find /home/ubuntu/copias_seguridad -type f -name "backup_*.sql" -mtime +7 -exec rm {} \;
