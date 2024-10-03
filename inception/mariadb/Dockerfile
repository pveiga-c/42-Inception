
# This Dockerfile sets up a MariaDB container using the Debian Bullseye base image.
FROM	debian:bullseye

# This Dockerfile exposes port 3306 for the MariaDB service.
# Port 3306 is the default port for MySQL/MariaDB database connections.
EXPOSE	3306

RUN		apt update && \
		apt install -y --no-install-recommends --no-install-suggests \
		mariadb-server && \
		rm -rf /var/lib/apt/lists/*

# Copy the setup.sh script from the tools directory to the /bin/ directory inside the Docker image.
COPY	tools/setup.sh /bin/

RUN		chmod +x /bin/setup.sh

# This Dockerfile command sets the default command to be executed when the container starts.
# It runs the "setup.sh" script followed by the "mysqld_safe" command to start the MariaDB server safely.
CMD	["setup.sh", "mysqld_safe"]