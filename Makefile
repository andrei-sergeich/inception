ENV			=	./srcs/.env
USER		=	$(shell whoami)
NICKNAME	=	cmero
PATH_DIR	=	/home/${USER}/data/{db,wp,adminer}

all: add_dns_to_host
	@mkdir -p ${PATH_DIR} 2>/dev/null || true
	sudo docker-compose -f  srcs/docker-compose.yml build    # собираем все
	sudo docker-compose -f  srcs/docker-compose.yml up
# sudo docker-compose -f  srcs/docker-compose.yml up -d    # запускаем в фоне

up:
	sudo docker-compose -f  srcs/docker-compose.yml up -d 

down:
	sudo docker-compose -f  srcs/docker-compose.yml down 

#### Nginx ####
enter_nginx:
	sudo docker exec -it nginx /bin/bash

### MariadDb ###
enter_mariadb:
	sudo docker exec -it mariadb /bin/bash

### wordpress ###
enter_wordpres:
	sudo docker exec -it wordpress /bin/bash

# check protocol
tls:
	openssl s_client -connect 127.0.0.1:443

## Volume
volumes:
	sudo docker volume ls

## Networks
networks:
	sudo docker network ls

## Ps
ps:
	sudo docker ps -a

pss:
	sudo docker-compose -f  srcs/docker-compose.yml ps

# Images
images:
	sudo docker images -a

## Удаляет папку (грубо говоря Volume) и заново создаем
recreatedir:
	@sudo rm -rf ${PATH_DIR} 2>/dev/null
	@mkdir ${PATH_DIR} 2>/dev/null

## останавливает все контейнейры
stop:
	sudo docker stop $$(sudo docker ps -aq) 2>/dev/null || echo " "

## запускаем все контейнейры
start:
	sudo docker start $$(sudo docker ps -aq) 2>/dev/null || echo " "

## удаляет контейнеры
remote:
	sudo docker rm $$(sudo docker ps -aq) 2>/dev/null || echo " "

## удаляет Volume
rm_volume:
	sudo docker volume rm $$(docker volume ls -q)  2>/dev/null || echo " "

rm_network:
	docker network rm $$(docker network ls -q) 2>/dev/null || echo " "

rm_dir:
	@sudo rm -rf /home/${USER}/data 2>/dev/null

clean:	stop remote rm_volume rm_network rm_dir
	sudo docker rm $$(sudo docker ps -aq) 2>/dev/null || echo " "

fclean:	clean
	sudo docker rmi -f $$(sudo docker images -aq) 2>/dev/null || echo " "
	sudo sed -i "s/127.0.0.1 ${NICKNAME}.42.fr//" /etc/hosts

add_dns_to_host:
	@echo "Задать доменное имя локальному сайту: ${NICKNAME}.42.fr"
	@echo "127.0.0.1 ${NICKNAME}.42.fr" | sudo tee -a /etc/hosts

re:	fclean all recreatedir add_dns_to_host

# how use docker don't sudos
# sudo groupadd docker
# sudo gpasswd -a $USER docker
# sudo service docker restart
# sudo docker volume rm inception-volume 
# sudo docker volume rm db-volume 
