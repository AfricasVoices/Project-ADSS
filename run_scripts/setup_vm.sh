#!/usr/bin/env bash

set -e

# Install Python 3.6
sudo apt update && sudo apt install -y python3.6 python3-pip git
pip3 install --user pipenv

# Install Docker
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install gsutil
sudo apt-get update && apt-get install -y lsb-release apt-transport-https curl gnupg git python2.7
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-sdk

# Install project dependencies
pipenv --three
pipenv sync