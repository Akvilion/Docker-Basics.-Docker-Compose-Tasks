# Data Management in Docker Tasks

## Practical Tasks

After completing all the practical tasks for this lesson, run the `checkup-storage` command in the course VM to verify your results. The command will check your work and display some secret phrases. Enter these phrases into the appropriate fields below the tasks.

### Task 1

1. Run a container in detached mode from the `alpine:3.17` image. Use the `-v [host-src]:[container-dest]` bind mount argument to mount the `/opt/docker/storage/task1` directory from your host machine into the `/home` directory inside the container.
2. Using the `docker exec` command, run a shell command for this container, navigate to the `/home` directory inside the container, and create two files: `myfile1` containing the string "Hello world!" and `myfile2` containing the string "Hello from EPAM!".
3. Exit from the container and verify that these two files (created inside the container) also exist in the `/opt/docker/storage/task1` directory.
4. Delete the `myfile1` file from the host machine, re-enter the container, and check that the file is also deleted inside the container (while `myfile2` should still exist).
5. Run the `docker volume ls` command to check if any volumes were created.

### Task 2

1. Run a container in detached mode with the name `mypostgres` from the `postgres:15.1` image, specifying one additional environment variable `POSTGRES_PASSWORD=mysecretpassword`.
2. Use the `docker inspect` command to find the name of the volume automatically created for your container.
3. Run the `docker volume ls` command and locate the volume identified in the previous step.
4. Use the `docker volume inspect` command to find the mountpoint on your host system for this volume. Check this location for PostgreSQL files.
5. Run a container named `myalpine` from the `alpine:3.17` image and use the `--volumes-from mypostgres` argument to share the volume created for the PostgreSQL container.
6. Use the `docker inspect` command to confirm that the new container uses the same volume as the PostgreSQL container. Enter the container and check the `/var/lib/postgresql/data/` directory.

### Task 3

1. Use the `docker volume create` command to create a volume named `my_volume`. Verify the volume with the `docker volume ls` command.
2. Run the PostgreSQL container from the previous task with the name `mypostgres2` and an additional argument `-v [host-src]:[container-dest]`, where `[host-src]` is `my_volume` and `[container-dest]` is `/var/lib/postgresql/data/`.
3. Use the `docker volume inspect` command to find the mountpoint on your host system for your volume. Check this location for PostgreSQL files.
4. Run a container named `myalpine2` from the `alpine:3.17` image and use the `--volumes-from mypostgres2` argument to share the volume created for the PostgreSQL container.
5. Use the `docker inspect` command to confirm that the new container uses the same volume as the PostgreSQL container. Enter the container and check the `/var/lib/postgresql/data/` directory.

### Task 4

1. Run a container in detached mode with the name `tmpfs_container` from the `nginx:1.23` image, specifying the arguments `--mount type=tmpfs,destination=/my_folder1` and `-v /tmp:/my_folder2`.
2. Use the `docker inspect` command to find the configurations for both volumes and compare them.
3. Use the `docker exec` command to enter the container and use the `dd` utility to create two 1 GB files named `speed_file` in `/my_folder1` and `/my_folder2`. Compare the write speeds of these files. (Use the command `dd if=/dev/zero of=/my_folder1/speed_file bs=512M count=1`). Save the output of the `dd` command in a file named `result` in the corresponding folders `/my_folder1` and `/my_folder2`.
4. Inside the container, create a file `/my_folder1/my_file1` containing the string "Hello from my_file1!" and another file `/my_folder2/my_file2` containing the string "Hello from my_file2!".
5. Exit the container and use the `docker stop` and `docker rm` commands to stop and delete this container. Afterward, check the content of the file `/tmp/my_file2`.

### Task 5

#### Sub-task 1

1. Run a container in detached mode with the name `backup_container` from the `nginx:1.23` image, specifying the argument `-v /etc/nginx`.
2. Launch a new container from the `alpine:3.17` image, mount the volume from the `backup_container` container, mount the host directory `/opt/docker/storage/task5` as `/backup`, and pass a command to tar the content of `/etc/nginx` to a `backup.tar` file inside the `/backup` directory (`tar cvf /backup/backup.tar /etc/nginx`).
3. After the backup is complete, check the `/opt/docker/storage/task5/backup.tar` file on your local host.

#### Sub-task 2

1. Run a new container in detached mode with the name `restore_container` from the `alpine:3.17` image, specifying the argument `-v /etc/nginx` and passing the command `sleep infinity`.
2. Launch a new container from the `alpine:3.17` image, mount the volume from the `restore_container` container, mount the host directory `/opt/docker/storage/task5` as `/backup`, and pass a command to untar the content of the `/backup/backup.tar` file to the `/etc/nginx` directory (`tar xvf /backup/backup.tar --strip 2 -C /etc/nginx`). Check the content of the `/etc/nginx` directory in the `restore_container` container.

### Task 6

1. Use the `docker volume create` command to create a volume named `sidecar_volume`.
2. Run a container in detached mode with the name `producer` from the `alpine:3.17` image, using the additional argument `-v [host-src]:[container-dest]` (where `[host-src]` is `sidecar_volume` and `[container-dest]` is `/home`). Add the following command for this container: `sh -c 'while sleep 5; do echo "Hello from EPAM!" >> /home/logs ; done'`.
3. Use the `docker exec` command to enter the container and check that every 5 seconds, a new line "Hello from EPAM!" is being added to the `/home/logs` file.
4. Run a new container in detached mode with the name `consumer` from the `alpine:3.17` image, using the additional argument `-v [host-src]:[container-dest]` (where `[host-src]` is `sidecar_volume` and `[container-dest]` is `/opt`). Add the following command for this container: `tail -f /opt/logs`. This container will print every 5 seconds a new message from the volume produced by the `producer` container.
