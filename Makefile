all: up

up:
	@docker compose -f ./srcs/docker-compose.yml up -d
down:
	@docker compose -f ./srcs/docker-compose.yml down
stop:
	@docker compose -f ./srcs/docker-compose.yml stop
start:
	@docker compose -f ./srcs/docker-compose.yml start

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

.PHONY: all up down stop start clean fclean re