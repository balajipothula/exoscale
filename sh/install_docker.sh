#!/bin/bash

# Author      : BALAJI POTHULA <balaji@significo.com>,
# Date        : 31 August 2016,
# Description : Install Docker CE and containerd.

# Update the package lists for repositories.
apt --yes --quiet update

# Upgrade the installed packages on the system.
apt --yes --quiet upgrade

# Remove packages that were no longer required.
apt --yes --quiet autoremove

# Install the required dependencies.
apt --yes --quiet install \
  apt-transport-https \
  ca-certificates \
  certbot \
  curl \
  git \
  net-tools \
  software-properties-common \
  tar

# Add the official Docker GPG key to verify the packages.
curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg |
  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the Docker repository to system's APT (Advanced Package Tool) sources.
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |
  tee /etc/apt/sources.list.d/docker.list >/dev/null

# Update the package lists for repositories.
apt --yes --quiet update

# Install Docker CE, Docker CE CLI and containerd.io
apt --yes --quiet install \
  docker-ce \
  docker-ce-cli \
  containerd.io

# Add current user to the docker group.
usermod --append ubuntu --groups docker
