# Instalar Odoo 16.0 con Docker Compose (Soporte para multiples instancias Odoo en servidor Linux Ubuntu).

## Instalación rápida

Instalar [docker](https://docs.docker.com/get-docker/) y [docker-compose](https://docs.docker.com/compose/install/) usted mismo, luego ejecute lo siguiente para configurar la primera instancia de Odoo @ `localhost:10016` (master password por defecto: `jorgegr.info`):

``` bash
curl -s https://raw.githubusercontent.com/minhng92/odoo-16-docker-compose/master/run.sh | sudo bash -s odoo-one 10016 20016
```
y/o ejecute lo siguiente para configurar otra instancia Odoo @ `localhost:11016` (default master password: `jorgegr.info`):

``` bash
curl -s https://raw.githubusercontent.com/minhng92/odoo-16-docker-compose/master/run.sh | sudo bash -s odoo-two 11016 21016
```

Algunos argumentos:
* **odoo-one**: carpeta de implementación de Odoo
* **10016**: puerto Odoo
* **20016**: puerto live chat

Si `curl` no está disponible, instálelo:

``` bash
$ sudo apt-get install curl
# or
$ sudo yum install curl
```

## Uso

Inicie el contenedor:
``` sh
docker-compose up
```
Luego abra `localhost:10016` para acceder a Odoo 16.0.

- **Si tiene algún problema con los permisos**, cambie el permiso de la carpeta para asegurarse de que el contenedor pueda acceder al directorio:

``` sh
$ sudo chmod -R 777 addons
$ sudo chmod -R 777 etc
$ sudo chmod -R 777 postgresql
```

- Si desea iniciar el servidor con un puerto diferente, cambie **10016** a otro valor en **docker-compose.yml** dentro del directorio principal:

```
puertos:
 - "10016:8069"
```

- Para ejecutar el contenedor Odoo en modo independiente (y poder cerrar la terminal sin detener Odoo):

```
docker-compose up -d
```

- To Use a restart policy, i.e. configure the restart policy for a container, change the value related to **restart** key in **docker-compose.yml** file to one of the following:
   - `no` =	Do not automatically restart the container. (the default)
   - `on-failure[:max-retries]` =	Restart the container if it exits due to an error, which manifests as a non-zero exit code. Optionally, limit the number of times the Docker daemon attempts to restart the container using the :max-retries option.
  - `always` =	Always restart the container if it stops. If it is manually stopped, it is restarted only when Docker daemon restarts or the container itself is manually restarted. (See the second bullet listed in restart policy details)
  - `unless-stopped`	= Similar to always, except that when the container is stopped (manually or otherwise), it is not restarted even after Docker daemon restarts.
```
 restart: always             # run as a service
```

- Para aumentar el número máximo de archivos que se ven de 8192 (predeterminado) a **524288** . Para evitar errores cuando ejecutamos múltiples instancias de Odoo. `Este es un paso opcional` . Estos comandos son para usuarios de Ubuntu:

```
$ if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi
$ sudo sysctl -p    # apply new config immediately
``` 

## Complementos personalizados

The **addons/** folder contains custom addons. Just put your custom addons if you have any.

## Configuración y registro de Odoo

* Para cambiar la configuración de Odoo, edite el archivo: **etc/odoo.conf**.
* Log file: **etc/odoo-server.log**
* La contraseña por defecto de la BD es (**admin_passwd**) es `jorgegr.info`, puede cambiarse en @ [etc/odoo.conf#L60](/etc/odoo.conf#L60)

## Gestión de contenedores Odoo

**Ejecute Odoo**:

``` bash
docker-compose up -d
```

**Reiniciar Odoo**:

``` bash
docker-compose restart
```

**Detener Odoo**:

``` bash
docker-compose down
```

## Live chat

En [docker-compose.yml#L21](docker-compose.yml#L21), expusimos el puerto **20016** para chat en vivo en el host.

Configuración **nginx** para activar la función de chat en vivo (en producción):

``` conf
#...
server {
    #...
    location /longpolling/ {
        proxy_pass http://0.0.0.0:20016/longpolling/;
    }
    #...
}
#...
```

## docker-compose.yml

* odoo:16.0
* postgres:15

## para activar la función de chat en vivo (en producción).

<img src="screenshots/odoo-16-welcome-screenshot.png" width="50%">

<img src="screenshots/odoo-16-apps-screenshot.png" width="100%">

<img src="screenshots/odoo-16-sales-screen.png" width="100%">

<img src="screenshots/odoo-16-product-form.png" width="100%">
