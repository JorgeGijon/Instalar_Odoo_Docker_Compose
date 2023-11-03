# Gestión de contenedores Odoo, etc..

**Ejecute Odoo**:
``` bash
docker-compose up -d
# o bien
$ sudo docker ps
$ sudo docker start [contenedor_Id] # sirven 4 primeros digitos
```
**Reiniciar Odoo**:
``` bash
docker-compose restart
# o bien
$ sudo docker ps
$ sudo docker restart [contenedor_Id] # sirven 4 primeros digitos
```
**Detener Odoo**:
``` bash
docker-compose down
# o bien
$ sudo docker ps
$ sudo docker stop [contenedor_Id] # sirven 4 primeros digitos
```
**Eliminar Odoo**:
``` bash
docker-compose down
# o bien
$ sudo docker ps
$ sudo docker rm [contenedor_Id] # sirven 4 primeros digitos
```
**Eliminar Carpeta Odoo**:
``` bash
$ sudo rm -r [carpeta_contenedor]  #borrar carpeta contenedora, ejemplo 'odoo-01'
```
<p align="right"><a href="#top">:arrow_up:</a></p>