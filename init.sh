#!/bin/bash
set -euo pipefail
# Uncomment the next line for debugging
# set -x

# -- proxy configuration
#export HTTP_PROXY=
#export HTTPS_PROXY=
#export NO_PROXY=

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
sudo python3 -m pip install --upgrade pip
export PATH="$(python3 -m site --user-base)/bin:$PATH"

# -- install ansible
echo "Installing ansible..."
pip3 install ansible && ansible --version

# -- clone repo
git clone git@github.com:PeterMue/MacOS-Ansible.git ~/.macos-ansible

pushd ~/.macos-ansible
    # -- spin it up
    ansible-galaxy install -r requirements.yaml
    ansible-playbook site.yaml
popd
