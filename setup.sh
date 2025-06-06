#!/bin/bash
set -euo pipefail
# Uncomment the next line for debugging
# set -x

# -- environment configuration
#export HTTP_PROXY=
#export HTTPS_PROXY=
#export NO_PROXY=
#export PIP_OPTS=

# -- this repo
CLONE_URL="${CLONE_URL:-git@github.com:PeterMue/MacOS-Ansible.git}"

# -- install command line tools
if xcode-select -p &>/dev/null; then
    echo "CommandLine Tools already installed"
else
    echo "Installing CommandLine Tools..."
    xcode-select --install

    until xcode-select -p &>/dev/null; do
        sleep 5
        echo "Waiting for completion..."
    done
fi

# -- upgarde pip
echo "Upgarde to latest pip..."
sudo python3 -m pip install $PIP_OPTS --upgrade pip
export PATH="$(python3 -m site --user-base)/bin:$PATH"

# -- install ansible
echo "Installing ansible..."
pip3 install $PIP_OPTS ansible && ansible --version

# -- clone repo
echo "Cloning repo from $CLONE_URL"
git clone "$CLONE_URL" ~/.macos-ansible

pushd ~/.macos-ansible
    # -- spin it up
    ansible-galaxy install -r requirements.yaml
    ansible-playbook playbook.yaml
popd
