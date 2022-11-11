ENV			=	./srcs/.env
USER		=	$(shell whoami)
NAME		=	inception
NICKNAME	=	cmero
DATA_DIR	=	/home/${USER}/data

all: add_dns_to_host
	@echo -e "\nЗапуск конфигурации ${NAME}..."
	@bash srcs/requirements/tools/mk_dir.sh 2>/dev/null || echo "ERROR: add_dns_to_hosts"
	@docker-compose -f  srcs/docker-compose.yml build    # собираем все
	@docker-compose -f  srcs/docker-compose.yml up
	@#docker-compose -f  srcs/docker-compose.yml up -d    # запускаем в фоне

build:
	@echo "Сборка конфигурации ${NAME}..."
	@docker-compose -f  srcs/docker-compose.yml build

up:
	@printf "Запуск конфигурации ${NAME}...\n"
	@docker-compose -f  srcs/docker-compose.yml up -d

down:
	@printf "Остановка конфигурации ${NAME}...\n"
	@docker-compose -f  srcs/docker-compose.yml down

#### Nginx ####
enter_nginx:
	docker exec -it nginx /bin/bash

### MariadDb ###
enter_mariadb:
	docker exec -it mariadb /bin/bash

### wordpress ###
enter_wordpres:
	docker exec -it wordpress /bin/bash

### redis ###
enter_redis:
	docker exec -it redis /bin/bash

### proftpd ###
enter_proftpd:
	docker exec -it proftpd /bin/bash

### website ###
enter_website:
	docker exec -it website /bin/bash

### adminer ###
enter_adminer:
	docker exec -it adminer /bin/bash

# check protocol
tls:
	openssl s_client -connect 127.0.0.1:443

## Volume
volumes:
	docker volume ls

## Networks
networks:
	docker network ls

## Ps
ps:
	docker ps -a

pss:
	docker-compose -f srcs/docker-compose.yml ps

# Images
images:
	docker images -a

## Удаляем папку (грубо говоря Volume) и заново создаем
recreatedir:
	@bash srcs/requirements/tools/mk_dir.sh 2>/dev/null || echo "ERROR: mk_dir"
	@bash srcs/requirements/tools/rm_dir.sh 2>/dev/null || echo "ERROR: rm_dir"

## останавливаем все контейнейры
stop:
	docker stop $$(docker ps -aq) 2>/dev/null || echo "ERROR: docker stop"

## запускаем все контейнейры
start:
	docker start $$(docker ps -aq) 2>/dev/null || echo "ERROR: docker start"

## удаляет контейнеры
remote:
	docker rm $$(docker ps -aq) 2>/dev/null || echo "ERROR: docker rm"

## удаляет Volume
rm_volume:
	docker volume rm $$(docker volume ls -q)  2>/dev/null || echo "ERROR: volume rm"

rm_network:
	docker network rm $$(docker network ls -q) 2>/dev/null || echo "ERROR: network rm"

rm_dir:
	@bash srcs/requirements/tools/rm_dir.sh 2>/dev/null || echo "ERROR: rm_dir"
	@#sudo rm -rf /home/${USER}/data 2>/dev/null

#clean:	stop remote rm_volume rm_network rm_dir
#	@echo "Очистка конфигурации ${NAME}..."
#	sudo docker rm $$(sudo docker ps -aq) 2>/dev/null || echo " "

clean: down
	@echo "Очистка конфигурации ${NAME}..."
	@docker system prune -a -f			# сносит все (неиспользуемые контейнеры, образы, кэш), кроме волиумов

#fclean:	clean
#	@echo "Полная очистка конфигурации ${NAME}..."
#	sudo docker rmi -f $$(sudo docker images -aq) 2>/dev/null || echo " "
#	sudo sed -i "s/127.0.0.1 ${NICKNAME}.42.fr//" /etc/hosts

fclean:
	@printf "Полная очистка всех конфигураций ${NAME}...\n"
	@docker stop $$(docker ps -qa) 2>/dev/null || echo "ERROR: docker stop"
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@bash srcs/requirements/tools/rm_dir.sh 2>/dev/null && echo "SUCCESS: rm_dir" || echo "ERROR: rm_dir"
	@bash srcs/requirements/tools/rm_dns_from_hosts.sh ${NICKNAME} 2>/dev/null && echo "SUCCESS: rm_dns_from_hosts" || echo "ERROR: rm_dns_from_hosts"
	@#sudo rm -rf ${DATA_DIR} 2>/dev/null
	@#sudo sed -i "s/127.0.0.1 ${NICKNAME}.42.fr//g" /etc/hosts

#re:	fclean recreatedir all

re:	down
	@echo "Пересборка конфигурации ${NAME}..."
	@docker-compose -f srcs/docker-compose.yml up -d --build

add_dns_to_host:
	@echo "Задать доменное имя локальному сайту: ${NICKNAME}.42.fr"
	@bash srcs/requirements/tools/add_dns_to_hosts.sh ${NICKNAME} 2>/dev/null && echo "SUCCESS: add_dns_to_hosts" || echo "ERROR: add_dns_to_hosts"
	@#echo -n "127.0.0.1 ${NICKNAME}.42.fr" | sudo tee -a /etc/hosts

.PHONY	: all build down re clean fclean add_dns_to_host

# how use docker don't sudos
# sudo groupadd docker
# sudo gpasswd -a $USER docker
# sudo service docker restart
# sudo docker volume rm inception-volume 
# sudo docker volume rm db-volume 
