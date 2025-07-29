FROM php:8.2-apache

# Install dependencies for pdo_pgsql
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Enable Apache rewrite (optional, good for Laravel or friendly URLs)
RUN a2enmod rewrite
