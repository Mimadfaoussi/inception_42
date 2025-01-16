FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && apt-get clean

RUN mkdir -p /etc/nginx/ssl


COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./conf/generate_cert.sh /usr/local/bin/generate_cert.sh

RUN chmod +x /usr/local/bin/generate_cert.sh


RUN /usr/local/bin/generate_cert.sh


EXPOSE 443


CMD ["nginx", "-g", "daemon off;"]
