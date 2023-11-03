#!/bin/bash

# Configuración de la base de datos PostgreSQL
PG_HOST=db                  #nombre_del_contenedor_postgres
PG_PORT=5432
PG_DATABASE=postgres        #nombre_de_la_base_de_datos
PG_USER=odoo                #nombre_de_usuario
PG_PASSWORD=odoo16@2024     #contraseña_del_usuario

# Ruta para almacenar las copias de seguridad
BACKUP_DIR=/copias_seguridad

# Nombre del archivo de copia de seguridad
BACKUP_FILE=backup_$(date +"%Y-%m-%d_%H-%M-%S").sql

# Realizar la copia de seguridad utilizando pg_dump
pg_dump -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DATABASE -w -F c -b -v -f $BACKUP_DIR/$BACKUP_FILE

# Eliminar copias de seguridad más antiguas de 7 días
find $BACKUP_DIR -type f -name "backup_*.sql" -mtime +7 -exec rm {} \;
