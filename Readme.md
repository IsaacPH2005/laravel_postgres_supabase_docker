# EcoHeroes Backend – Laravel 12 + Docker

Este repositorio contiene el entorno de desarrollo oficial para el backend de EcoHeroes, basado en Laravel 12 y PostgreSQL, orquestado con Docker y Docker Compose. Incluye servicios para PHP-FPM, Nginx, PostgreSQL y pgAdmin.

---

## Requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop) (incluye Docker Engine y Docker Compose)
- Git

---

## Estructura del Proyecto

```
tu-repo/
├── docker-compose.yml
├── dockerfiles/
│   ├── composer.dockerfile
│   ├── nginx.dockerfile
│   └── php.dockerfile
├── nginx/
│   └── default.conf
├── postgres/
│   └── .env
└── servidor/
  ├── app/
  ├── bootstrap/
  ├── config/
  ├── database/
  ├── public/
  └── ... (archivos de Laravel)
```

---

## Instalación y Primer Uso

1. **Clona el repositorio**

   ```bash
   git clone https://github.com/tu-usuario/tu-repo.git
   cd tu-repo
   ```

2. **Genera la clave de la aplicación Laravel**

   Antes de continuar, asegúrate de generar la clave de la aplicación. Esto es necesario para que el backend funcione correctamente.

   ```bash
   # Si ya tienes el archivo .env, ejecuta:
   docker compose run --rm artisan key:generate
   ```

   Si aún no tienes el archivo `.env`, sigue los pasos siguientes para crearlo y luego ejecuta el comando anterior.

3. **Configura PostgreSQL**

   ```bash
   mkdir -p postgres
   ```

   Crea `postgres/.env` con:

   ```ini
   POSTGRES_DB=ecoheroes_db
   POSTGRES_USER=ecoheroes_user
   POSTGRES_PASSWORD=tu_contraseña_segura
   ```

4. **Crea el proyecto Laravel (si no existe)**

   ```bash
   docker compose up -d --build php composer
   docker compose run --rm composer create-project laravel/laravel . "12.x"
   ```

5. **Configura el entorno de Laravel**

   ```bash
   cp servidor/.env.example servidor/.env
   ```

   Edita `servidor/.env`:

   ```ini
   APP_URL=http://localhost:8080

   DB_CONNECTION=pgsql
   DB_HOST=postgres
   DB_PORT=5432
   DB_DATABASE=ecoheroes_db
   DB_USERNAME=ecoheroes_user
   DB_PASSWORD=tu_contraseña_segura
   ```

6. **Genera la clave de la aplicación** (si no lo hiciste antes)

   ```bash
   docker compose run --rm artisan key:generate
   ```

7. **Levanta todos los servicios**

   ```bash
   docker compose up -d --build
   ```

---

## Acceso a Servicios

- **Backend Laravel:** [http://localhost:8080](http://localhost:8080)
- **pgAdmin:** [http://localhost:5050](http://localhost:5050)
  - Email: `admin@ecoheroes.com`
  - Contraseña: `ecoheroes_admin_password`
  - Al agregar un servidor: Host: `postgres`, Puerto: `5432`, Usuario: `ecoheroes_user`, Contraseña: la de `.env`

---

## Comandos Útiles

- **Detener y limpiar todo (incluye volúmenes y datos):**
  ```bash
  docker compose down --volumes --rmi all
  ```
- **Detener servicios (mantiene datos):**
  ```bash
  docker compose down
  ```
- **Ver estado de contenedores:**
  ```bash
  docker compose ps
  ```
- **Ver logs de un servicio:**
  ```bash
  docker compose logs -f php
  ```
- **Ejecutar migraciones:**
  ```bash
  docker compose run --rm artisan migrate
  ```
- **Instalar dependencias Composer:**
  ```bash
  docker compose run --rm composer install
  ```
- **Actualizar dependencias Composer:**
  ```bash
  docker compose run --rm composer update
  ```
- **Acceder a la shell del contenedor PHP:**
  ```bash
  docker compose exec php bash
  ```

---

## Notas Importantes

- **Permisos:** Los Dockerfiles están configurados para que el usuario `Laravel` tenga los permisos adecuados. No es necesario modificar permisos manualmente.
- **Base de datos:** Si eliminas los volúmenes, perderás los datos de la base de datos.
- **Variables sensibles:** No subas archivos `.env` con contraseñas reales a repositorios públicos.

---

## Licencia

Este proyecto está bajo la licencia MIT.

---

¿Dudas o sugerencias? Abre un issue o contacta al equipo de desarrollo.

