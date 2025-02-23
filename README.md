# Desplegar multiples instancias Odoo v16, v17 y v18, con Docker Compose, en servidor Linux Ubuntu.
<!-- Menu  -->
<p align="center">
<b><a href="#instalación">Instalación</a></b>
|
<b><a href="#uso">Uso</a></b>
|
<b><a href="#complementos">Complementos</a></b>
|
<b><a href="#anexo">Anexo</a></b>
</p>

<br>

## Instalación

Instalar [docker](documents/instalar_docker.md) y [docker-compose](documents/instalar_docker_compose.md).
Si `curl` no está disponible, instalar:
``` bash
$ sudo apt-get install curl
# o bien
$ sudo yum install curl
```
Ejecutar siguiente `curl` para configurar la primera instancia de Odoo @ `localhost:10001`. Argumentos por defecto para reemplazar:
* **run_v{}.sh**: cambiar para diferentes **versiones** _v16/_v17/_v18
* **odoo-01**: carpeta de implementación de Odoo
* **10001**:    puerto Odoo
* **20001**:    puerto `live chat`
* **pass.por.defecto**:    `master password` BD
``` bash
curl -s https://raw.githubusercontent.com/JorgeGijon/Instalar_Odoo_Docker_Compose/main/run_v16.sh | sudo bash -s odoo-01 10001 20001 pass.por.defecto
```

y/o ejecute el siguiente para configurar otra instancia Odoo @ `localhost:10002`. Argumentos por defecto para reemplazar:
* **run_v{}.sh**: cambiar para diferentes **versiones** _v16/_v17/_v18
* **odoo-02**: carpeta de implementación de Odoo
* **10002**:    puerto Odoo
* **20001**:    puerto `live chat`
* **pass.por.defecto**:    `master password` BD
``` bash
curl -s https://raw.githubusercontent.com/JorgeGijon/Instalar_Odoo_Docker_Compose/main/run_v16.sh | sudo bash -s odoo-02 10002 20001 pass.por.defecto
```

## Uso

Inicie el contenedor:
``` sh
docker-compose up
```
Luego abra `localhost:10001` para acceder a Odoo _v16/_v17/_v18.

- **Si tiene algún problema con los permisos**, cambie el permiso de la carpeta para asegurarse de que el contenedor pueda acceder al directorio:

``` sh
$ sudo chmod -R 777 addons
$ sudo chmod -R 777 etc
$ sudo chmod -R 777 postgresql
```

- Si desea iniciar el servidor con un puerto diferente, cambie **10001** a otro valor en **docker-compose.yml** dentro del directorio principal:

```
puertos:
 - "10001:8069"
```

- Para ejecutar el contenedor Odoo en modo independiente (y poder cerrar la terminal sin detener Odoo):

```
docker-compose up -d
```

- Para utilizar una política de reinicio, es decir, configurar la política de **reinicio** para un contenedor, cambie el valor relacionado con la clave de **reinicio** en el archivo **docker-compose.yml** a uno de los siguientes:
   - `no` =	No reinicie automáticamente el contenedor. (el valor por defecto)
   - `on-failure[:max-retries]` = Reinicie el contenedor si sale debido a un error, que se manifiesta como un código de salida distinto de cero. Opcionalmente, limite la cantidad de veces que el `daemon` Docker intenta reiniciar el contenedor usando la opción `:max-retries`.
  - `always` =	Reinicie siempre el contenedor si se detiene. Si se detiene manualmente, se reinicia solo cuando se reinicia el demonio Docker o cuando se reinicia manualmente el contenedor. (Consulte la segunda viñeta que figura en los detalles de la política de reinicio)
  - `unless-stopped`	= Similar a `always`, excepto que cuando el contenedor se detiene (manualmente o de otra manera), no se reinicia incluso después de que se reinicia el `daemon` Docker.
```
 restart: always             # correr como un servicio
```

- Para aumentar el número máximo de archivos que se ven de 8192 (predeterminado) a **524288** . Para evitar errores cuando ejecutamos múltiples instancias de Odoo. `Este es un paso opcional` . Estos comandos son para usuarios de Ubuntu:

```
$ if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi
$ sudo sysctl -p    # aplicar nueva configuración
``` 
<p align="right"><a href="#top">:arrow_up:</a></p>

## Complementos
La carpeta **addons/** contiene complementos personalizados. Simplemente coloque sus complementos personalizados si tiene alguno.
<!--<p align="right"><a href="#top">:arrow_up:</a></p>-->

## Configuración y registro de Odoo
* Para cambiar la configuración de Odoo, edite el archivo: **etc/odoo.conf**.
* Log file: **etc/odoo-server.log**
* La contraseña por defecto de la BD (**admin_passwd**) es `pass.por.defecto`, puede cambiarse en @ [etc/odoo.conf#L60](/etc/odoo.conf#L60)
<!--<p align="right"><a href="#top">:arrow_up:</a></p>-->

## docker-compose.yml
* odoo:16.0
* postgres:15
<!--<p align="right"><a href="#top">:arrow_up:</a></p>-->

## Capturas de pantalla de Odoo 16.0 después de desplegar

<img src="screenshots/odoo-16-welcome-screenshot.png" width="49%" style="margin:0 auto 0 auto;"> <img src="screenshots/odoo-16-apps-screenshot.png" width="49%" style="margin:0 auto 0 auto;">
<!--
<img src="screenshots/odoo-16-sales-screen.png" width="100%">
<img src="screenshots/odoo-16-product-form.png" width="100%">
-->
<p align="right"><a href="#top">:arrow_up:</a></p>

# Anexo

Después de instalar Odoo se recomiendan algunas opciones:
* [Despliegue Odoo en puerto 80 y 443](documents/servicios_web.md)
* [Programar copia seguridad BD PostgresSQL](documents/copia_seguridad_postgres.md)
* [Despliegue Live Chat](documents/live_chat.md)
<p align="right"><a href="#top">:arrow_up:</a></p>

Documentación adicional de interés:
* [Recomendaciones Odoo](documents/recomendaciones_odoo.md)
* [Gestión de contenedores Docker](documents/gestion_contenedores.md)
<p align="right"><a href="#top">:arrow_up:</a></p>
