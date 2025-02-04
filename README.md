Peter's MacOS Setup
===================

This repository contains Ansible playbooks, roles, and a setup script to configure a MacOS environment.
It includes tasks for installing Homebrew, various packages, casks, dotfiles, shell configurations, and Java versions.


## Requirements

- Supported MacOS version 15.0.0 or higher (tested)
- Internet connection for downloading packages and casks

Note: While this setup has been tested on MacOS 15, it may also work on others

## Playbooks

### Main Playbook

- **playbook.yml**: This is the main playbook that orchestrates the setup process.

### Configuration Files

- **config.yaml**: Variables and configurations used by the playbooks.

## Roles

- **homebrew**: Installs and updates Homebrew, and installs specified packages and casks.
- **dotfiles**: Clones the dotfiles repository and uses `stow` to manage symbolic links.
- **shell**: Configures the shell, installs Oh-My-Zsh, and sets custom paths.
- **java**: Installs specified Java versions, updates `cacerts`, and configures `jenv`.

## Variables

### Homebrew Packages

The following Homebrew packages will be installed:
- tree
- htop
- jq
- yq
- neovim
- stow (default)
- ripgrep-all (default)

### Homebrew Casks

The following Homebrew casks will be installed:
- microsoft-teams
- postman
- autodesk-fusion
- microsoft-office
- visual-studio-code

### Dotfiles

- **dotfiles_git_repo**: `git@github.com:PeterMue/dotfiles.git`
- **dotfiles_dest**: `~/.dotfiles`
- **dotfiles_version**: `main`

### Java Versions

The following Java versions will be installed:
- zulu@21
- zulu@17
- zulu@8

### Java CACerts

- **java_cacerts_uri**: URL to download updated `cacerts` file.

## Setup Script

A setup script is included to install necessary command line tools, upgrade pip, install Ansible, and clone this repository.

### Script: `setup.sh`

The `setup.sh` script automates the initial setup process. It performs the following tasks:
- Installs Command Line Tools (if not already installed)
- Upgrades pip to the latest version
- Installs Ansible
- Clones this repository
- Runs the Ansible playbooks

## Usage

### Option 1: Use as is

1. Run the setup script directly from the repository:
    ```sh
    curl -fsSL https://raw.githubusercontent.com/PeterMue/macos-setup/main/setup.sh | sh
    ```

### Option 2: Fork and Customize

1. Fork the repository and clone it:
    ```sh
    git clone git@github.com:YourUsername/macos-setup.git
    cd macos-setup
    ```

2. Create the `config.yaml` file with your configurations:
    ```yaml
    homebrew_packages:
      - logi-options+
    homebrew_casks: []
    dotfiles_git_repo: 'git@github.com:PeterMue/dotfiles.git'
    java_versions:
      - zulu@21
      - zulu@17
      - zulu@8
    java_cacerts_uri: https://your-cacerts-uri
    ```

3. Run the playbook:
    ```sh
    ansible-galaxy install -r requirements.yaml
    ansible-playbook playbook.yml --ask-become-pass
    ```

## Contributions

Feel free to open issues and submit pull requests for any improvements or fixes.

## License

This project is licensed under the MIT License.

