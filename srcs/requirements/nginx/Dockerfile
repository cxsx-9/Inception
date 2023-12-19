FROM debian:bullseye

# Install nginx and openssl
RUN apt-get update
RUN apt-get install -y nginx openssl

# SSL certificate
RUN openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/private.key \
    -out /etc/nginx/public.crt \
    -subj "/C=TH/L=Bangkok/O=42/CN=csantivi.42.fr"

RUN rm -rf /etc/nginx/sites-enabled/default
COPY ./conf/nginx.conf /etc/nginx/sites-enabled/csantivi.42.fr

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
