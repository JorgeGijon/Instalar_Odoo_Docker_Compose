Configurar Nginx como Proxy Inverso

    Instala Nginx (si no está instalado):
    Si no tienes Nginx instalado en tu servidor, instálalo usando:

    bash

sudo apt-get update
sudo apt-get install nginx

Crea un Archivo de Configuración para Nginx:
Crea un nuevo archivo de configuración para tu sitio web de Odoo en el directorio /etc/nginx/sites-available/. Por ejemplo, puedes crear un archivo llamado odoo:

nginx

server {
    listen 80;
    server_name tu_dominio_o_ip; # Reemplaza con tu dominio o IP pública

    location / {
        proxy_pass http://localhost:8069;
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

Asegúrate de reemplazar tu_dominio_o_ip con tu dominio o IP pública.

Crea un Enlace Simbólico a sites-enabled:
Crea un enlace simbólico del archivo de configuración de Nginx a la carpeta sites-enabled:

bash

sudo ln -s /etc/nginx/sites-available/odoo /etc/nginx/sites-enabled

Configura un Certificado SSL (Opcional, para HTTPS):
Si deseas habilitar HTTPS, configura un certificado SSL para tu dominio utilizando Let's Encrypt u otro proveedor de certificados SSL.

Reinicia Nginx:
Una vez que hayas configurado Nginx, reinícialo para aplicar los cambios:

bash

    sudo service nginx restart

Ahora, Odoo debería estar accesible en tu dominio o IP pública a través de los puertos 80 (HTTP) y 443 (HTTPS si has configurado SSL). Asegúrate de que los puertos 80 y 443 estén abiertos en tu firewall y redirige el tráfico de estos puertos a tu servidor si estás detrás de un router o firewall de red. Además, asegúrate de que tu dominio esté configurado correctamente para apuntar a la IP pública de tu servidor.




1. Instalar Certbot y el Complemento de Nginx:

Primero, asegúrate de tener Certbot instalado en tu servidor Ubuntu:

bash

sudo apt-get update
sudo apt-get install certbot python3-certbot-nginx

2. Obtener un Certificado SSL:

Usa Certbot para obtener un certificado SSL para tu dominio. Reemplaza tu_dominio con tu nombre de dominio real:

bash

sudo certbot --nginx -d tu_dominio

Certbot solicitará una dirección de correo electrónico y pedirá que aceptes los términos de servicio. Luego, te preguntará si deseas redirigir el tráfico HTTP a HTTPS. Asegúrate de seleccionar la opción para redirigir el tráfico para que Certbot configure automáticamente la redirección desde HTTP al puerto 443.
3. Verificar la Configuración de Nginx:

Certbot debería haber configurado automáticamente Nginx para que maneje el tráfico HTTPS. Puedes verificar la configuración de Nginx para asegurarte de que todo esté en orden:

bash

sudo nginx -t

Si la sintaxis es correcta, reinicia Nginx para aplicar los cambios:

bash

sudo systemctl restart nginx

4. Automatizar las Renovaciones de Certificados:

Certbot configurará automáticamente una tarea cron para renovar tus certificados. No necesitas hacer nada más para que los certificados se renueven automáticamente.
5. Verificar la Configuración de Certbot (Opcional):

Para verificar la configuración de Certbot y ver cuándo se renovarán los certificados, puedes ejecutar:

bash

sudo certbot certificates

Esto mostrará información sobre tus certificados SSL, incluyendo la fecha de vencimiento y cuándo se renovarán.