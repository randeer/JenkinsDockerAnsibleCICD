FROM new_remote_ubuntu

RUN apt-get update && \
    apt-get install -y \
    nginx \
    php-fpm \
    php-cli \
    php-curl \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-pear

EXPOSE 80

VOLUME /var/www/html /var/log/nginx /var/log/php-fpm /var/lib/php-fpm

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./bin/start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh
