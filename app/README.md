# App Wapii Api

## Requerimientos de la aplicacion
* Version de Ruby: 3.1.0.
* Version de Rails: 6.1.4.4.
* Despliegue local: Docker y Docker-Compose.
* Base de datos asociada (Sin uso no requerida): Postgres11 Alpine.
* Instrucciones de despliegue en directorio principal del repositorio.
* Librerias o gemas usadas para el desarrollo del requerimiento:

```
gem 'pg', '~> 1.2.3'
gem 'pry', '~> 0.13.1'
gem 'rack-cors'
gem "faraday"
gem 'will_paginate', '~> 3.3.0'
gem 'rspec-rails', '~> 3.5'
```


## Funcionalidades

### Esta Api resuelve los siguientes requerimientos:

- Visualización paginada de publicaciones (10 por página) 
Cada publicación debe contar con el nombre del autor, el título de la publicación, el texto de la publicación, los primeros 3 comentarios y el número total de comentarios.

```
https://app-wapii-api.herokuapp.com/posts
https://app-wapii-api.herokuapp.com/posts?page=2
```
- Endpoint /users 
Obtener la lista de usuarios ordenados decrecientemente por cantidad de publicaciones.

[nombre de usuario, cantidad de publicaciones] 
```
https://app-wapii-api.herokuapp.com/users
```
- Endpoint /trending/:n 
Obtener las n publicaciones con más comentarios.

[título, texto (body), nombre de usuario autor] 
```
https://app-wapii-api.herokuapp.com/trending
https://app-wapii-api.herokuapp.com/trending/5
https://app-wapii-api.herokuapp.com/trending/n
```
- Endpoint /influencers 
Obtener los 5 usuarios mas populares (mayor cantidad de comentarios, en la menor cantidad de publicaciones).

[nombre de usuario, índice de popularidad]
```
https://app-wapii-api.herokuapp.com/influencers
https://app-wapii-api.herokuapp.com/influencers/5
https://app-wapii-api.herokuapp.com/influencers/n
```

### Enlace a la API desplegada en Heroku

https://app-wapii-api.herokuapp.com
