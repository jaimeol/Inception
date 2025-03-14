COMPOSEPATH     = ./srcs/docker-compose.yaml
MYSQL_NAME      = mysql
WEBSERVER_NAME  = webserver
DATA_PATH       = /home/jolivare
DATA_DIR        = ${DATA_PATH}/data/
MYSQL_DIR       = ${DATA_DIR}${MYSQL_NAME}
WEBSERVER_DIR   = ${DATA_DIR}${WEBSERVER_NAME}

all: ${DATA_DIR} ${MYSQL_DIR} ${WEBSERVER_DIR}
	docker compose -f ${COMPOSEPATH} up -d --build

${MYSQL_DIR} ${WEBSERVER_DIR}: ${DATA_DIR}
	mkdir -p $@

${DATA_DIR}:
	mkdir -p ${DATA_DIR}

down:
	docker compose -f ${COMPOSEPATH} down

fclean: down
	docker volume rm -f ${MYSQL_NAME} ${WEBSERVER_NAME} 2>/dev/null || true
	sudo rm -rf ${DATA_DIR}

clean:
	docker rmi -f $$(docker images -q -f "reference=*wordpress*") 2>/dev/null || true
	docker rmi -f $$(docker images -q -f "reference=*nginx*") 2>/dev/null || true
	docker rmi -f $$(docker images -q -f "reference=*mariadb*") 2>/dev/null || true

ps:
	docker compose -f ${COMPOSEPATH} ps

logs:
	docker compose -f ${COMPOSEPATH} logs -f

re: fclean all

.PHONY: all clean fclean re ps logs down