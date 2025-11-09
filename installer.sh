#!/bin/bash

# Auto Installer Docker + Portainer
# Tested on Ubuntu 20.04+

set -e

echo "🚀 Memulai instalasi Docker dan Portainer..."

# Update dan install dependensi
sudo apt update && sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    lsb-release

# Tambahkan GPG key Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Tambahkan repository Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Aktifkan dan jalankan Docker
sudo systemctl enable docker
sudo systemctl start docker

# Tambahkan user ke grup docker (opsional)
sudo usermod -aG docker $USER

# Jalankan Portainer menggunakan Docker
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo "✅ Instalasi selesai!"
echo "🔗 Akses Portainer di https://localhost:9443"
