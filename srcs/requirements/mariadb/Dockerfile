FROM debian:bullseye

# Install mariadb-server
RUN apt-get update \
    && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# create directory for mysqld 
RUN mkdir -p /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/
COPY ./tools/script.sh  /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/script.sh" ]
CMD [ "mysqld" ]
