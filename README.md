# Docker + Portainer Auto-Installer

This script automates the installation of Docker Engine and Portainer-CE on Ubuntu systems.

## Overview

The `installer.sh` script is designed to quickly set up a Docker environment along with the Portainer-CE management UI. It handles adding the necessary repositories, installing packages, and deploying the Portainer container.

## Prerequisites

* An Ubuntu system (Tested on Ubuntu 20.04+).
* Access to a user account with `sudo` privileges.

## Usage

1.  Make the script executable:
    ```bash
    chmod +x installer.sh
    ```

2.  Run the script:
    ```bash
    ./installer.sh
    ```

The script will execute all necessary steps automatically.

## What the Script Does

The installer performs the following actions:

1.  **System Update:** Runs `sudo apt update` and installs necessary dependencies (`apt-transport-https`, `ca-certificates`, `curl`, `software-properties-common`, `gnupg`, `lsb-release`).
2.  **Add Docker GPG Key:** Downloads and adds Docker's official GPG key.
3.  **Add Docker Repository:** Adds the official Docker `apt` repository to the system's sources.
4.  **Install Docker Engine:** Installs `docker-ce`, `docker-ce-cli`, and `containerd.io`.
5.  **Start Docker Service:** Enables and starts the Docker systemd service.
6.  **Add User to Docker Group:** Adds the current `$USER` to the `docker` group.
    * **Note:** You may need to log out and log back in for this change to take effect.
7.  **Deploy Portainer:**
    * Creates a persistent Docker volume named `portainer_data`.
    * Runs the `portainer/portainer-ce:latest` image.
    * Names the container `portainer` and sets it to always restart.
    * Maps ports `8000:8000` and `9443:9443` (host:container).
    * Mounts the Docker socket (`/var/run/docker.sock`) to allow Portainer to manage the Docker environment.
    * Mounts the `portainer_data` volume to `/data` for persistent configuration.

## Post-Installation

After the script completes successfully, you can access the Portainer web UI to create your administrator account and start managing Docker.

* **URL:** `https://localhost:9443`

(If you are running this on a remote server, replace `localhost` with your server's public IP address).