# Programar copia seguridad de BD PostgresSQL

sudo apt install postgresql-client-common
pg_dump --version


1. Ejecutar siguiente `curl` para configurar la copia de la Base Datos. Argumentos por defecto para reemplazar:
* **e897**: id contendor de postgresql `sudo docker ps`
``` bash
curl -s https://raw.githubusercontent.com/JorgeGijon/Instalar_Odoo_Docker_Compose/main/backup.sh | sudo bash -s e897
```

2. Crear fichero en `/home/ubuntu/odoo-01/backup.sh`
``` bash
sudo nano /home/ubuntu/odoo-01/backup.sh
```
y copiar:
``` sh
#!/bin/bash

ID_CONTENEDOR=e897                                  #nombre contenedor o id del docker postgresql (sirven 4 dig)
PG_DATABASE=postgres                                #nombre_de_la_base_de_datos
PG_USER=odoo                                        #nombre_de_usuario
PG_PATH=/home/ubuntu/copias_seguridad               #ruta local donde colocar carpeta backups
BACKUP_FILE=backup_$(date +"%Y-%m-%d_%H-%M-%S").sql

# Comprobar carpeta backups y permisos
if [ ! -d $PG_PATH ]; then
    # Si no existe, crea el directorio
    sudo mkdir -p  $PG_PATH
    sudo chmod 777 $PG_PATH
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
```

3. Hacer el Script Ejecutable:
``` bash
sudo chmod +x backup.sh
``` 

4. Configurar un Cronjob:
Usa crontab -e para abrir el editor de crontab y programa el script para que se ejecute según la frecuencia que desees. Por ejemplo, para ejecutar la copia de seguridad todos los días a las 2 AM, agrega la siguiente línea:
``` bash
0 2 * * * /home/ubuntu/odoo-01/backup.sh
```