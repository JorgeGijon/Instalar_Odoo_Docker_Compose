# Programar copia seguridad de BD PostgresSQL

sudo apt install postgresql-client-common
pg_dump --version


1. Ejecutar siguiente `curl` para configurar la copia de la Base Datos. Argumentos por defecto para reemplazar:
* **e897**: id contendor de postgresql `sudo docker ps`
``` bash
curl -s https://raw.githubusercontent.com/JorgeGijon/Instalar_Odoo_Docker_Compose/main/backup.sh | sudo bash -s e897
```

2. Crear fichero en `/home/ubuntu/odoo-01/backup.sh`  (copiar contenido fichero [backup.sh](/backup.sh))

3. Hacer el Script Ejecutable:
``` bash
chmod +x backup.sh
``` 

4. Configurar un Cronjob:
Usa crontab -e para abrir el editor de crontab y programa el script para que se ejecute según la frecuencia que desees. Por ejemplo, para ejecutar la copia de seguridad todos los días a las 2 AM, agrega la siguiente línea:
``` bash
0 2 * * * /home/ubuntu/odoo-01/backup.sh
```