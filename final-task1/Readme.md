# Final Task: Web Server Infrastructure with Docker Compose

## Overview

This task involves creating a small web-server infrastructure using Docker Compose. The goal is to deploy a WordPress application running on an Apache web server, connected to a standalone MySQL database container.

## Task Breakdown

### Sub-task 1: WordPress and MySQL Containers

You need to create a 2-container setup using Docker Compose, with one container running WordPress on Apache and the other running MySQL as the database. Follow the instructions below to complete the setup.

### General Notes

- Templates are located at `/opt/docker/source/final-task-1/`. Copy them to `/opt/docker/final-task1` and use this directory as your working directory.
- Use `.yml` as the extension for the Docker Compose file.
- Use the following volume names:
  - `mysql` for the database
  - `wordpress` for the application

### Application: WordPress with Apache

- **Container 1**: Web-server with WordPress running on it
  - Use the Dockerfile in the folder for building your image.
  - Base the build on `wordpress:latest`.
  - WordPress should be available at port `8080`. For example, `http://VM_IP_ADDRESS:8080` should display the WordPress start page.
  - Name the container: `my-awesome-wordpress`.
  - Use a custom bridge network called `my-awesome-network`.
  - Configure WordPress using the `wp-config.php` file, placing it in the container's `/var/www/html` directory.
  - Ensure `wp-config.php` file ownership is changed to `www-data` inside the container.
  - The container should always restart in case of failures, but not when stopped explicitly.
  - Configuration should persist even after container restarts.

### Database: MySQL with Custom Configuration

- **Container 2**: Database container running MySQL
  - Name the container: `my-awesome-database`.
  - Ensure this container starts first. Set up a dependency between the database and WordPress containers.
  - Use the `mysql:5.7` image.
  - Configure access using environment variables (refer to the official image documentation).
  - Ensure the WordPress and MySQL containers can communicate using their container names.
  - The container should always restart in case of failures, but not when stopped explicitly.
  - Ensure database files persist even after container restarts.

### Final Check

- Run `checkup-final1` in the `/opt/docker/final-task1` directory to validate your setup.
