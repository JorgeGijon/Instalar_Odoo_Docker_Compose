# Desplegar servicios

## Configurar Nginx como Proxy Inverso  **puerto 80**
Instala Nginx (si no está instalado):
``` bash
sudo apt-get update
sudo apt-get install nginx
``` 
Crea un Archivo de Configuración para Nginx en el directorio **/etc/nginx/sites-available/**. Por ejemplo, puedes crear un archivo llamado **odoo-01** con editor:

``` bash
server {
    listen 80;
    server_name [odoo.jorgegr.com]; # Reemplaza con tu dominio o IP pública

    location / {
        proxy_pass http://localhost:[10001];  # Reemplaza por puerto Odoo 
        proxy_set_header Host $host;
        proxy_redirect off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        add_header X-Content-Type-Options nosniff;
    }

    access_log /var/log/nginx/odoo.access.log;
    error_log /var/log/nginx/odoo.error.log;
}
``` 
Crea un enlace simbólico del archivo de configuración de Nginx **odoo-01** a la carpeta sites-enabled:
``` bash
sudo ln -s /etc/nginx/sites-available/[odoo-01] /etc/nginx/sites-enabled
``` 

## Configura un Certificado SSL (Opcional, para HTTPS) **puerto 443**
1. Instalar Certbot:
``` bash
sudo apt-get update
sudo apt-get install certbot python3-certbot-nginx
``` 
2. Obtener un Certificado SSL:
Usa Certbot para obtener un certificado SSL para tu dominio. Reemplaza tu_dominio con tu nombre de dominio real:
``` bash
sudo certbot --nginx -d [odoo.jorgegr.com]  # Reemplaza por tu dominio o IP 
``` 
Certbot solicitará una dirección de correo electrónico y pedirá que aceptes los términos de servicio. Luego, te preguntará si deseas redirigir el tráfico HTTP a HTTPS. Asegúrate de seleccionar la opción para redirigir el tráfico para que Certbot configure automáticamente la redirección desde HTTP al puerto 443.
3. Verificar la Configuración de Nginx:
``` bash
sudo nginx -t
``` 
Si la sintaxis es correcta, reinicia Nginx para aplicar los cambios:
``` bash
sudo systemctl restart nginx
``` 
4. Certbot configurará automáticamente una tarea cron para renovar tus certificados. No necesitas hacer nada más para que los certificados se renueven automáticamente.
5. Verificar la Configuración de Certbot (Opcional):
``` bash
sudo certbot certificates
``` 
Esto mostrará información sobre tus certificados SSL, incluyendo la fecha de vencimiento y cuándo se renovarán.

Ahora, Odoo debería estar accesible en tu dominio o IP pública a través de los puertos 80 (HTTP) y 443 (HTTPS si has configurado SSL). Asegúrate de que los puertos 80 y 443 estén abiertos en tu firewall y redirige el tráfico de estos puertos a tu servidor si estás detrás de un router o firewall de red. Además, asegúrate de que tu dominio esté configurado correctamente para apuntar a la IP pública de tu servidor.




