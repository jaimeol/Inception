all:
	@docker compose -f ./srcs/docker-compose.yaml up --build

down:
	@docker compose -f ./srcs/docker-compose.yaml down

rmdata:
	@sudo rm -rf /home/jolivare/data/mariadb_data/*
	@sudo rm -rf /home/jolivare/data/wordpress_data/*
	@docker system prune -a --volumes -f

re:
	@docker compose -f srcs/docker-compose.yaml up -d --build

ps:
	@docker ps;

.PHONY: all re down rmdata clean