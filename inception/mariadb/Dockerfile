
# This Dockerfile sets up a MariaDB container using the Debian Bullseye base image.
FROM	debian:bullseye

# This Dockerfile exposes port 3306, which is the default port for MySQL/MariaDB.
EXPOSE	3306

# Update the package list and install MariaDB server without recommended or suggested packages.
# After installation, clean up the local repository of retrieved package files.
RUN		apt update && apt install -y --no-install-recommends --no-install-suggests \
		mariadb-server && \ rm -rf /var/lib/apt/lists/*

# Copy the custom MariaDB configuration file from the local directory to the MariaDB 
# configuration directory inside the container.
COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copy the setup.sh script from the tools directory to the /bin/ directory inside the container.
COPY	tools/setup.sh /bin/

# Grant execute permissions to the setup.sh script located in the /bin directory.
RUN		chmod +x /bin/setup.sh

# This Dockerfile sets up the MariaDB service for the Inception project.
# The CMD instruction specifies the commands to be executed when the container starts.
# It runs the "setup.sh" script followed by "mysqld_safe" to ensure the MariaDB server starts safely.
CMD		["setup.sh", "mysqld_safe"]