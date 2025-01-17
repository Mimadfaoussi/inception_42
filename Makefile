WP_DATA=/home/mfaoussi/data/wordpress 
DB_DATA=/home/mfaoussi/data/mariadb

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker-compose.yml up -d
down:
	docker compose -f ./srcs/docker-compose.yml down
stop:
	docker compose -f ./srcs/docker-compose.yml stop
start:
	docker compose -f ./srcs/docker-compose.yml start
build:
	docker compose -f ./srcs/docker-compose.yml build

# clean the containers
# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
# the (|| true) is used to ignore the error if there are no containers running to prevent the make command from stopping.
clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f
