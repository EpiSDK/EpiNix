# Nix-OS-Config

## Introduction

Hello ! This repo its a for Epitech Student who migrate or take a another distro : Nix Os. 

This is a full configuration Fast-and-Set

## Content

This repo have all tools for epitech student : 

 * Clang
 * Epiclang (with Epifaster)
 * gcovr 
 * Git
 * Criterion
 * Valgrind
 * Make
 * Htop
 * Go
 * And python

And for application you have : 

 * VsCode
 * Zed Editor
 * Zen-Brower
 * Micro-Fetch


## How to use ?

### Requirement

* Do have Nix OS installation finish
* WIFI

### Installation

1. First you need to have git for clone this repo. Nix OS have a temp shell for try all command whitout installation

 ```bash
 nix-shell -p git
 ```

After, git clone this repo

```bash
git clone https://github.com/EpiSDK/EpiNix.git
```

2. After clone lets modify configuration for your user and see who work NixOS.

*  Follow all comment for change all the configuration for user, 
*  Add other packages for application 

3. Finish ? The configuration is alredy to use. 

Use the following commande for copy the configuration on the NixOs emplacement

```bash
cp config.nix /etc/nixos
cp home.nix /etc/nixos
cp flake.nix /etc/nixos
```

4. Final step : now run the final command and enjoy ! Its finish

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

All app are install and you can use