FROM composer:2.5.1 AS composer
FROM php:8.2-fpm
COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY composer.json /var/www/html
RUN composer install --no-dev
RUN apt-get update
RUN apt-get -y install libzip-dev
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_mysql
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug