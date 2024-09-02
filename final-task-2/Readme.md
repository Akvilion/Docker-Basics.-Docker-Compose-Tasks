# Sub-task 2: Vet Clinic Application Setup

## Task Overview

Our client wants us to start the best vet clinic application ever so everyone can be sure that their lovely pets are healthy and happy ^_^. However, the team's environment is currently misconfigured. This task involves fixing the environment to get the application up and running smoothly.

## General Notes

- There are some templates that should be used to solve this task, located at `/opt/docker/source/final-task-2/`. 
- Copy these templates to `/opt/docker/final-task2` and use it as your working directory.
- Ensure that you run `checkup-final2` in this directory as well.
- Use `.yml` instead of `.yaml` for the Compose file extension.

## Environment Description

- **Docker Compose File**: 
  - The `docker-compose.yml` file is used to manage the environment.
  - It serves two containers, volumes, and the Petclinic network.
  - A copy of this file should be in your working directory.

- **Petclinic Application**:
  - The application runs in a container and is accessible on port `8080` both inside and outside the container.
  - The container uses an image built from the `Dockerfile` file.
  - A copy of this `Dockerfile` should be in your working directory.

- **Database Engine**:
  - Runs in a separate container using the `hlebsur/mysql:8` image.
  - This image contains a hint in its metadata.

## Acceptance Criteria

- The Petclinic app must be accessible from the browser on port `8080`.
- You must be able to see the doctors' list and view or change the pet owners' list.
- The application container's status must be healthy for the entire lifecycle.
- You should check the DB image metadata for any hints.

## Hints

- **Application Logs**: 
  - Check the logs for the app container. 
  - Seeing a beautiful healthy cat taking a nap on the logo means the application has started correctly. You can then try accessing it via the browser.
  - However, this does not guarantee that everything is functioning correctly. Ensure that you can view the lists of clients and doctors, and make/save changes to them.

- **Java Command**:
  - Pay attention to the Java command passed in the `Dockerfile`.

