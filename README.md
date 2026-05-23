# Nix-OS-Config

## Introduction

Hello! This repository provides a starter NixOS configuration for Epitech students who are migrating from another distribution.

It is a ready-to-use configuration focused on getting set up quickly.

## Content

This repo includes common tools for Epitech students:

 * Clang
 * Epiclang (with Epifaster)
 * Gcovr
 * Git
 * Criterion
 * Valgrind
 * Make
 * Htop
 * Go
 * Python

Applications included:

 * VS Code
 * Zed Editor
 * Zen Browser
 * Microfetch


## How to use?

### Requirements

* NixOS installed
* Working network connection (Wi-Fi or Ethernet)

### Installation

1. First, you need Git to clone this repository. NixOS provides a temporary shell to try commands without installing packages permanently:

 ```bash
 nix-shell -p git
 ```

Then clone the repository:

```bash
git clone https://github.com/EpiSDK/EpiNix.git
```

2. After cloning, edit the configuration for your user and make sure it matches your system.

* Follow the comments to update the username and related paths.
* Add or remove packages as needed.

3. When you are ready, copy the configuration files to the NixOS location:

```bash
cp config.nix /etc/nixos
cp home.nix /etc/nixos
cp flake.nix /etc/nixos
```

4. Final step: rebuild and switch to the new configuration:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

All applications are installed and ready to use.

## More?

### Use Hyprland?

This configuration enables GNOME as the desktop environment, but NixOS can also enable Hyprland if you want a more customized setup.

For an example Hyprland configuration, see: https://github.com/Tadomika-Ari/My-NixOs-Configuration#

### Other packages?

Follow the comments to add other apps/tools:
* `home.nix` for user-specific packages
* `config.nix` for system-wide packages

## Repository tree

```text
.
├── README.md
├── config.nix
├── flake.nix
├── home.nix
└── setup.sh
```
