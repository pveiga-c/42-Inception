include srcs/.env

.SILENT:

all:
	clear
	sudo mkdir -p $(VOLUMES_DATA)/data/mariadb $(VOLUMES_DATA)/data/wordpress;
	$(COMPOSE) up -d

start:
	clear
	$(COMPOSE) up -d

stop:
	clear
	$(COMPOSE) stop

clean:
	clear
	$(COMPOSE) down --rmi all --volumes

fclean: clean
	sudo rm -irf $(VOLUMES_DATA)/data

re: fclean all

# Display containers logs
logs:
	clear
	$(COMPOSE) logs

# Display containers details
info:
	clear
	echo "*****    $(COMPOSE) ps -a   *****"
	$(COMPOSE) ps -a
	echo "\n*****   $(DOCKER) images   *****"
	$(DOCKER) images
	echo "\n*****   $(DOCKER) network ls   *****"
	$(DOCKER) network ls
	echo "\n*****   $(DOCKER) volume ls   *****"
	$(DOCKER) volume ls

# Interactive mode
mariadb-it:
	clear
	$(DOCKER) exec -it $(MARIADB) /bin/bash

nginx-it:
	clear
	$(DOCKER) exec -it $(NGINX) /bin/bash

wordpress-it:
	clear
	$(DOCKER) exec -it $(WORDPRESS) /bin/bash

.PHONY: all start stop clean fclean logs info mariadb-it nginx-it wordpress-it
