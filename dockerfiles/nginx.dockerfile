FROM nginx:stable-alpine

# Copia el archivo de configuración de Nginx directamente a la ubicación correcta
# Usamos 'nginx/default.conf' como origen y '/etc/nginx/conf.d/default.conf' como destino.
# El 'mv' que tenías era redundante si copias directamente al destino final.
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# El WORKDIR /var/www/html no es estrictamente necesario aquí si solo vas a copiar el código.
# Es más relevante en Dockerfiles de PHP o Composer.
# Sin embargo, si quieres que este sea el directorio de trabajo predeterminado para futuros comandos
# o para facilitar la depuración, puedes mantenerlo.
WORKDIR /var/www/html

# Copia el contenido de tu aplicación desde el host (carpeta 'servidor') al contenedor.
# Esto es correcto y asegura que Nginx tenga acceso a los archivos de tu Laravel.
COPY servidor .

# Opcional: Establecer los permisos correctos para los archivos del servidor web
# El usuario 'nginx' (o 'www-data' en otras distribuciones) necesita leer el código.
# Esto es una buena práctica de seguridad.
RUN chown -R nginx:nginx /var/www/html
RUN chmod -R 755 /var/www/html

# No necesitas un ENTRYPOINT ni CMD aquí si estás usando la imagen oficial de Nginx,
# ya que la imagen ya tiene un CMD que inicia Nginx.

EXPOSE 80 
# Expone el puerto 80 del contenedor, aunque ya lo haces en docker-compose