FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && apt-get clean

COPY ./conf/init_db.sh /usr/local/bin/init_db.sh

RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

CMD ["sh", "/usr/local/bin/init_db.sh"]
