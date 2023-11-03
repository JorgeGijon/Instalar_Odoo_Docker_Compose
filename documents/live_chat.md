# Live chat

En [docker-compose.yml#L21](../docker-compose.yml#L21), expusimos el puerto **20001** para chat.

Configuración [nginx](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/) para activar la función de chat (en producción):

``` conf
#...
server {
    #...
    location /longpolling/ {
        proxy_pass http://0.0.0.0:20001/longpolling/;
    }
    #...
}
#...
```
<p align="right"><a href="#top">:arrow_up:</a></p>