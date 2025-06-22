FROM php:8.2-fpm-alpine

# Instala las dependencias del sistema y las extensiones de PHP necesarias primero
RUN apk add --no-cache \
    msmtp perl wget procps shadow libzip libpng libjpeg-turbo libwebp-dev freetype icu \
    postgresql-dev && \
    apk add --no-cache --virtual .build-deps \
    icu-dev zlib-dev g++ make automake autoconf libzip-dev \
    libpng-dev libjpeg-turbo-dev freetype-dev libwebp-dev && \
    \
    # Configurar e instalar GD
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install gd && \
    \
    # Instalar extensiones PDO y otras necesarias
    docker-php-ext-install pdo pdo_pgsql intl bcmath opcache exif zip && \
    \
    # Limpiar dependencias de construcción
    apk del .build-deps && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /etc/php82/php-fpm.d/www.conf

# Instala y habilita la extensión Redis
RUN apk add --no-cache pcre-dev $PHPIZE_DEPS && \
    pecl install redis && \
    docker-php-ext-enable redis.so && \
    apk del pcre-dev $PHPIZE_DEPS

# Crea el usuario Laravel. Esto debe hacerse antes de copiar el código si se le van a dar permisos al usuario.
RUN addgroup -g 1000 Laravel && adduser -G Laravel -g Laravel -s /bin/sh -D Laravel

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Copia el contenido de tu aplicación desde el host al contenedor
COPY servidor .

# Ahora, solo cambiamos la propiedad del directorio raíz de la aplicación al usuario Laravel.
# Laravel se encargará de crear y manejar los permisos de 'storage' y 'bootstrap/cache' en tiempo de ejecución.
RUN chown -R Laravel:Laravel /var/www/html

# Cambia al usuario Laravel
USER Laravel

# Exponer el puerto de PHP-FPM
EXPOSE 9000

# Comando para iniciar PHP-FPM
CMD ["php-fpm"]