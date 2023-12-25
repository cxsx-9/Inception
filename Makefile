all: up

up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build
down:
	@docker compose -f ./srcs/docker-compose.yml down
stop:
	@docker compose -f ./srcs/docker-compose.yml stop
start:
	@docker compose -f ./srcs/docker-compose.yml start

clear:
	@if [ ! -z $$(docker ps -aq) ]; then \
		docker stop $$(docker ps -aq); \
		docker rm $$(docker ps -aq); \
	else \
		echo ": No container is running"; \
	fi

clean: clear down
	@if [ ! -z $$(docker images -aq) ]; then \
		docker image rm -f $$(docker images -qa); \
	fi
	@if [ ! -z $$(docker volume ls -q) ]; then\ 
	docker volume rm $$(docker volume ls -q); \
	fi

fclean: clear
	docker system prune -af
	docker volume prune -f

re:	fclean up

.PHONY: all up down stop start clean fclean re