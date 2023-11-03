#!/bin/bash
ID_CONTENEDOR=$1        #nombre contenedor o id del docker postgresql (sirven 4 dig)

# Variables
PG_DATABASE=postgres                                #nombre_de_la_base_de_datos
PG_USER=odoo                                        #nombre_de_usuario
PG_PATH=/home/ubuntu/copias_seguridad               #ruta local donde colocar carpeta backups
BACKUP_FILE=backup_$(date +"%Y-%m-%d_%H-%M-%S").sql

# Comprobar carpeta backups y permisos
if [ ! -d $PG_PATH ]; then
    # Si no existe, crea el directorio
    sudo mkdir -p  $PG_PATH
    sudo chmod -R 777 $PG_PATH
    echo "Se ha creado el directorio: " $PG_PATH
else
    # Si ya existe, muestra un mensaje
    echo "El directorio "$PG_PATH" ya existe."
fi
# Realizar la copia de seguridad utilizando pg_dump
sudo docker exec -t $ID_CONTENEDOR pg_dump -U $PG_USER $PG_DATABASE > $PG_PATH/$BACKUP_FILE
# Borrar Backup de + 7 dias
sudo find $PG_PATH -type f -name "backup_*.sql" -mtime +7 -exec rm {} \;
echo "Copia de seguridad realizada: "$BACKUP_FILE