# Recomendaciones despliegue de Odoo 16.0

## Instalar el controlador de impresora (Opcional):
Si necesitas la funcionalidad de impresión en PDF desde Odoo, instala el controlador de impresora CUPS:
``` bash
sudo apt-get install -y printer-driver-all
``` 
## Generar informes en PDF (wkhtmltopdf):
Puedes descargar e instalar el paquete desde el sitio web oficial de wkhtmltopdf.
``` bash
sudo apt-get install -y fonts-noto-cjk
sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin
sudo ln -s /usr/local/bin/wkhtmltoimage /usr/bin
``` 
## Reinicia el servidor:
Después de instalar todas las dependencias, reinicia el servidor para asegurarte de que todos los cambios surtan efecto:
``` bash
sudo reboot
``` 