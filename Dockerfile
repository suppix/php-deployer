FROM php:7.4-alpine

RUN apk add --update --no-cache rsync git openssh

RUN wget https://deployer.org/releases/v7.0.0-beta.17/deployer.phar && \
    mv deployer.phar /usr/local/bin/dep && \
    chmod +x /usr/local/bin/dep

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN composer require deployer/recipes --dev
