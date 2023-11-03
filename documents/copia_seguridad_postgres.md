# Programar copia seguridad de BD PostgresSQL

1. Ejecutar fichero backup.sh
``` bash
curl -s https://raw.githubusercontent.com/JorgeGijon/Instalar_Odoo_Docker_Compose/main/backup.sh | sudo bash 
```

2. Hacer el Script Ejecutable:
``` bash
chmod +x backup.sh
``` 

3. Configurar un Cronjob:
Usa crontab -e para abrir el editor de crontab y programa el script para que se ejecute según la frecuencia que desees. Por ejemplo, para ejecutar la copia de seguridad todos los días a las 2 AM, agrega la siguiente línea:
``` bash
0 2 * * * /ruta/completa/del/backup.sh
```