FROM debian:bullseye

# Install php
RUN apt-get update \
    && apt-get install -y wget php php-fpm php-mysql
    # && rm -rf /var/lib/apt/lists/*

# Install wordpress (wp-cli)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./tools/script.sh  /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/script.sh" ]
CMD [ "php-fpm7.4", "--nodaemonize" ]