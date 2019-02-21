#!/usr/bin/env bash

set -e

PROJECT_ROOT="~/app"

sudo apt update && sudo apt install -y python3.6 python3-pip git
pip3 install --user pipenv

cd "$PROJECT_ROOT/Project-ADSS"
pipenv --three

sudo apt-get install \
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
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Get Coda V2
cd "$PROJECT_ROOT"
git clone "https://github.com/AfricasVoices/CodaV2.git"

cd CodaV2/data_tools
pipenv --three && pipenv update  # Update needed due to the corrupted Pipfile.lock in data_tools
