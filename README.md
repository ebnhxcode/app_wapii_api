
# App Wapii Api Net

## Configuración e Instalación en Desarrollo

### Paso 1: Lectura de Requisitos Previos

- [x] Docker
- [x] Docker Compose
- [x] (Opcional según sea el caso) Tener una instancia de Postgres (Puede ser en Local o en algún Servidor externo) que posteriormente se deberá configurar.

#### Paso 2 (Opcional): Config. de Aliases, abreviaciones para docker compose

Si usas MacOS ó Linux, en tu archivo **.bashrc**, **.profile** o **.zshrc**, copia y pega al final del archivo lo siguiente:

Aliases:
```
alias dc='docker-compose'
alias dce='docker-compose exec'
alias dcr='docker-compose run'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcstop='docker-compose stop'
```

Para activarlos simplemente ejecuta el comando según el archivo que utilizas:

Solo escoge el comando del archivo que utilizas en tu terminal
```
source ~/.bashrc
source ~/.profile
source ~/.zshrc
```

### Paso 3: Configurar las variables de entorno

Crea un nuevo archivo de variables de entorno en el directorio deploy/local/ con el nombre .env con las siguientes variables (Puedes modificar las variables segun tu usuario, password y host de la base):

```
# En el caso de usar URL
DATABASE_URL=postgres://postgres:Postgres2019!@postgres:5432/appwapiidb

# En el caso de usar variables de configuración
POSTGRES_DB=appwapiidb
POSTGRES_USER=postgres
POSTGRES_PASS=Postgres2019!

# Descomentar y usar solo una según el caso

# Cuando tienes el motor corriendo en otra instancia por ip o servicio
# POSTGRES_HOST=hostorip

# Cuando usas la instalación con el motor en la misma instancia
# POSTGRES_HOST=postgres


SMTP_USER=
SMTP_DOMAIN=
SMTP_SECRET=
SMTP_PORT=25
SMTP_ADDRESS=
SMTP_FROM_EMAIL=

RAILS_LOG_TO_STDOUT=true
RAILS_LOG_LEVEL=debug
```


### Paso 4: Instalación y Ejecución en entorno Local (2 opciones), favor leer bien las instrucciones y elegir una de las opciones segun sea el caso (Opción 1 u Opción 2):

Revisa el archivo docker-compose.yml para que puedas identificar los contenedores que van a ser llamados en los pasos posteriores para que puedas comprender que servicio es el que se levanta en cada opción.

#### Opción 1: Levantar la aplicación rails en local y conectandola a postgres en un servidor externo.

Si deseas desplegar solo la aplicación y tienes el motor de base de datos de postgres ya corriendo en otra instancia o servidor ejecuta lo siguiente y luego sigue las instrucciones de los siguientes pasos:

Instalación de la imagen:
```
docker-compose up -d --build appwapiiapi
```

Luego debes eliminar el fichero Gemfile.lock, para incluir todas las nuevas dependencias en el bundle.

Para instalar dependencias que se hayan configurado de forma manual en el paso anterior (Opcional, pero si lo realizaste debes ejecutarlo de igual forma).
```
docker-compose run --entrypoint='sh /usr/local/bin/bundle-deps' appwapiiapi sh -c
```

Ejecutamos la creación de la base de datos y corremos las migraciones:
```
docker-compose run --entrypoint='rails db:create' appwapiiapi
docker-compose run --entrypoint='rails db:migrate' appwapiiapi
docker-compose run --entrypoint='rails db:seed' appwapiiapi
```

Finalmente levantar la aplicación:
```
docker-compose run --publish 3030:3030 --entrypoint='sh /usr/local/bin/init-app' appwapiiapi sh -c
```

#### Opción 2:
Si deseas desplegar el contenedor de la app más la base de datos incluida en el build ejecuta lo siguiente y luego sigue las instrucciones de los siguientes pasos:

Instalación de la imagen:
```
docker-compose up -d --build appwapiiapipg
```

Luego debes eliminar el fichero Gemfile.lock, para incluir todas las nuevas dependencias en el bundle.

Para instalar dependencias que se hayan configurado de forma manual en el paso anterior (Opcional, pero si lo realizaste debes ejecutarlo de igual forma).
```
docker-compose run --entrypoint='sh /usr/local/bin/bundle-deps' appwapiiapipg sh -c
```

Ejecutamos la creación de la base de datos y corremos las migraciones:
```
docker-compose run --entrypoint='rails db:create' appwapiiapipg
docker-compose run --entrypoint='rails db:migrate' appwapiiapipg
docker-compose run --entrypoint='rails db:seed' appwapiiapipg
```

Finalmente levantar la aplicación:
```
docker-compose run --publish 3030:3030 --entrypoint='sh /usr/local/bin/init-app' appwapiiapipg sh -c
```