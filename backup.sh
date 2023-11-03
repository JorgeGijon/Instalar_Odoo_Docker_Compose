#!/bin/bash
#ID_CONTENEDOR=$1

# Configuración de la base de datos PostgreSQL
PG_DATABASE=postgres                                #nombre_de_la_base_de_datos
PG_USER=odoo                                        #nombre_de_usuario
PG_PATH=/home/ubuntu/copias_seguridad               #ruta local donde colocar carpeta backups
ID_CONTENEDOR=e897                                  #nombre contenedor o id del docker postgresql (sirven 4 dig)
BACKUP_FILE=backup_$(date +"%Y-%m-%d_%H-%M-%S").sql

# Realizar la copia de seguridad utilizando pg_dump
#sudo docker exec -it e897 /bin/bash
#sudo docker ps
if [ ! -d $PG_PATH ]; then
    # Si no existe, crea el directorio
    sudo mkdir -p  $PG_PATH
    sudo chmod 777 $PG_PATH
    echo "Se ha creado el directorio: " $PG_PATH
else
    # Si ya existe, muestra un mensaje
    echo "El directorio "$PG_PATH" ya existe."
fi
#sudo mkdir /home/ubuntu/copias_seguridad
#sudo chmod 777 /home/ubuntu/copias_seguridad
sudo docker exec -t $ID_CONTENEDOR pg_dump -U $PG_USER $PG_DATABASE > $PG_PATH/$BACKUP_FILE
sudo find $PG_PATH -type f -name "backup_*.sql" -mtime +7 -exec rm {} \;
echo "Copia de seguridad realizada: "$BACKUP_FILE