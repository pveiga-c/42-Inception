all: up

up: build
	@echo "**********Docker up**********\n" 
	@sudo mkdir -p /home/pveiga-c/data/wordpress
	@sudo mkdir -p /home/pveiga-c/data/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@echo "**********Docker down**********\n" 
	@docker-compose -f ./srcs/docker-compose.yml down

stop:
	@echo "**********Docker stop**********\n" 
	@docker-compose -f ./srcs/docker-compose.yml stop

start:
	@echo "**********Docker start**********\n" 
	@docker-compose -f ./srcs/docker-compose.yml start

build:
	@echo "**********Docker build**********\n" 
	@docker-compose -f ./srcs/docker-compose.yml build

logs:
	clear
	@echo "**********Docker logs**********\n" 
	@docker-compose -f ./srcs/docker-compose.yml logs

ps:
#	clear
	@echo "**********Docker containers**********\n" 
	@docker ps -a

images:
#	clear
	@echo "\n**********Docker images**********\n"
	@docker images

volumes:
#	clear
	@echo "\n**********Docker volumes**********\n"
	@docker volume ls


networks: 
#	clear
	@echo "\n**********Docker networks**********\n" 
	@docker network ls

list: ps images volumes networks
	@echo "**********Docker list**********\n\n"


clean:
	clear
	@docker-compose -f ./srcs/docker-compose.yml down --rmi all --volumes

fclean: clean
	@sudo rm -irf /home/pveiga-c/data


re: fclean up

