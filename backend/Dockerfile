FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    libzip-dev \
    zip \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pgsql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip

RUN pecl install redis && docker-php-ext-enable redis

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache

ARG PHP_FPM_PORT

RUN sed -i "s/9000/${PHP_FPM_PORT}/" /usr/local/etc/php-fpm.d/zz-docker.conf

RUN usermod -u 1000 www-data

WORKDIR /var/www/html

CMD ["php-fpm"]
