# Docker Basics: Docker Compose Tasks

## Practical Task Overview

All sub-tasks for this lesson should be completed in the `/opt/docker/dockercompose` directory. After completion, run `checkup-compose` in the same directory of the course VM to verify your results. The command will check your work and display some secret phrases. Enter the phrases into the appropriate fields below the tasks.

---

## Task 1: Install Docker Compose

- Ensure Docker Compose is installed on your system.

---

## Task 2: Define a Simple Service

### Frontend Service

1. Define a service named `frontend` using the image `phpmyadmin:5.2.0-apache`.
2. Use a Dockerfile to build a custom image.
3. Add the package `iputils-ping` into the image.
4. Start the newly defined service.
5. Expose the `phpmyadmin` service port `80` to your host port `8080`.
6. Define a custom network named `dockercompose-frontend` and attach the `frontend` service to that network.

### DB Service

1. Define a service named `mydb` using the current LTS `mariadb` version image.
2. Use a Dockerfile to build a custom image.
3. Add the package `iputils-ping` into the image.
4. Check the connection between `mydb` and `phpmyadmin` services using `ping`.
5. Attach the `mydb` service to the `dockercompose-frontend` network and check the connection again.

---

## Task 3: Configure phpMyAdmin

1. **Environment Variables**:
   - Read the related documentation.
   - Set the MySQL server host and MySQL server port via environment variables for `phpmyadmin` using the documentation from the previous step.

2. **Define MySQL Data Volume**:
   - Define a MySQL data volume and attach it to the `mydb` service.
   - Ensure that MariaDB uses it as a data storage (by default, it is `/var/lib/mysql`).

---

## Task 4: Set Healthcheck

1. **Define Healthcheck**:
   - Define a `mydb` service healthcheck based on `mysqladmin ping` with an interval of `10s`, a timeout of `15s`, and retries of `5`. Refer to this [page](https://docs.docker.com/compose/compose-file/compose-file-v3/#healthcheck) for more details.

2. **Break and Fix MySQL Service**:
   - Try to break the MySQL service inside the container by changing data file permissions, renaming MySQL data files, or experimenting with the healthcheck command (including defining an incorrect command).
   - Check the MySQL container status/health.
   - Fix the MySQL service and ensure the healthcheck is successful.

---

## Task 5: Configure Service Dependency

- Define the `phpmyadmin` service to start only if the `mydb` service health is OK.
- Stop all services and start them again, paying attention to the containers' start order.

---

## Task 6: Create and Manage Database

1. **SQL Operations**:
   - Using phpMyAdmin's SQL editor, execute the following commands:

     ```sql
     create database mydb;

     use mydb;

     create table mytable (
       id int AUTO_INCREMENT primary key,
       data text,
       datamodified timestamp default now()
     );

     insert into mytable(data) values("testdata01");
     insert into mytable(data) values("testdata02");
     insert into mytable(data) values("testdata03");
     ```

2. **MySQL Dump**:
   - Make a MySQL dump using another MySQL container with an attached volume for MySQL backup.
   - Save the dump to `/opt/docker/dockercompose/task-13/mydb.sql`.

---

Complete these tasks and run the verification command as instructed to ensure everything is set up correctly.
