## Instalar Docker

Actualizar el sistema:
``` bash
sudo apt update && sudo apt upgrade -y
```
Instalar Docker desde el repositorio oficial:
``` bash
sudo apt install -y docker.io
```
Verificar la instalación:
``` bash
docker --version
```
`Deberías ver algo como: Docker version XX.XX.XX`

Permitir que Docker se ejecute sin sudo:
``` bash
sudo usermod -aG docker $USER
```
Luego, reinicia sesión o ejecuta:
``` bash
newgrp docker
```
