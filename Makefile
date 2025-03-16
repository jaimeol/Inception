all:
	@docker compose -f ./srcs/docker-compose.yaml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yaml down

rmdata:
	@docker volume rm srcs_mariadb_data srcs_wordpress_data
	@docker system prune -a

re:
	@docker compose -f srcs/docker-compose.yaml up -d --build

ps:
	@docker ps;

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\

.PHONY: all re down rmdata clean