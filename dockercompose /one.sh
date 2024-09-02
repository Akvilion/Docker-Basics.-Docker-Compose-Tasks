#!/bin/bash

# Backup directory on the host
BACKUP_DIR="/opt/docker/dockercompose/task-13"

# Database credentials and details
DB_USER="root"
DB_PASSWORD="mysecretpassword"
DB_NAME="mydb"
NETWORK="dockercompose-frontend"

# Docker image version of MySQL
MYSQL_IMAGE="mysql:latest"

# Backup filename
BACKUP_FILENAME="$BACKUP_DIR/$DB_NAME.sql"

# Run mysqldump within a new Docker container
docker run --rm \
  --name mydb-dump \
  --network $NETWORK \
  -v mysql_data:/var/lib/mysql \
  -v $BACKUP_DIR:/backup \
  $MYSQL_IMAGE \
  sh -c "mysqldump --column-statistics=0 -h $DB_NAME -u $DB_USER -p$DB_PASSWORD $DB_NAME > /backup/$(basename $BACKUP_FILENAME)"
