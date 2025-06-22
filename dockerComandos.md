# Comandos para configurar un proyecto Laravel con Docker y Supabase

```bash
# Detiene y elimina los contenedores, volúmenes y las imágenes creadas por docker compose
docker compose down --volumes --rmi all

# Construye y levanta los contenedores en segundo plano
docker compose up -d --build

# Ejecuta Composer para crear un nuevo proyecto de Laravel en la versión 12.x dentro del contenedor
docker compose run --rm composer create-project laravel/laravel . "12.x"

# Instala Laravel Breeze como dependencia de desarrollo
docker compose run --rm composer require laravel/breeze --dev

# Instala el scaffolding de Breeze para API
docker compose run --rm  artisan breeze:install api

# Ejecuta las migraciones de la base de datos
docker compose run --rm  artisan migrate
```


docker compose exec php sh
php artisan migrate
docker compose run --rm composer require laravel/sanctum
docker compose run --rm artisan config:clear
docker compose run --rm artisan cache:clear
docker compose down
docker compose up -d
docker compose run --rm artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
docker compose run --rm artisan route:list

DB_CONNECTION=pgsql # <-- ¡Cambia a 'pgsql' para PostgreSQL!
DB_HOST=postgres    # <-- ¡IMPORTANTE! Este es el nombre del servicio en docker-compose.yml
DB_PORT=5432        # <-- Puerto predeterminado de PostgreSQL
DB_DATABASE=practicas_laravel_db # <-- Debe coincidir con POSTGRES_DB de postgres/.env
DB_USERNAME=practicas_laravel_user # <-- Debe coincidir con POSTGRES_USER de postgres/.env
DB_PASSWORD=root_pass # <-- Debe coincidir con POSTGRES_PASSWORD de postgres/.env

docker compose run --rm artisan install:api

## 5. Comandos adicionales útiles

```bash
# Ver el estado actual
git status

# Ver los commits en develop que no están en main
git log main..develop --oneline

# Ver diferencias entre ramas
git diff main..develop

# Verificar en qué rama estás
git branch