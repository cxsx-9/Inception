all: up

up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build
down:
	@docker compose -f ./srcs/docker-compose.yml down
stop:
	@docker compose -f ./srcs/docker-compose.yml stop
start:
	@docker compose -f ./srcs/docker-compose.yml start

clear: # for debug when didn't use docker compose 
	@if [ $$(docker ps -q | wc -l) -gt 0 ]; then \
		docker stop $$(docker ps -q); \
		echo ": stop all container"; \
	else \
		echo ": No container is running"; \
	fi
	@if [ $$(docker ps -qa | wc -l) -gt 0 ]; then \
		docker rm $$(docker ps -aq); \
		echo ": remove all container"; \
	else \
		echo ": No container exists"; \
	fi

clean: down
	@if [ $$(docker images -q | wc -l) -gt 0 ]; then \
		docker image rm -f $$(docker images -qa); \
	fi
	@if [ $$(docker volume ls -q | wc -l) -gt 0 ]; then \
		docker volume rm $$(docker volume ls -q); \
	fi

fclean: clean
	docker system prune -af
	docker volume prune -f

re:	fclean up

.PHONY: all up down stop start clean clear fclean re