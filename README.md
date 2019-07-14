# @cumpsd • dotfiles

## Table of Contents

- [@cumpsd • dotfiles](#cumpsd-•-dotfiles)
  - [Goal](#goal)
  - [Prerequisites on an Ubuntu based machine](#prerequisites-on-an-ubuntu-based-machine)
  - [Prerequisites on an Arch based machine](#prerequisites-on-an-arch-based-machine)
  - [Setup an Ubuntu or Arch based machine](#setup-an-ubuntu-or-arch-based-machine)
  - [Post Install steps on WSL](#post-install-steps-on-wsl)
    - [Change Console to Solarized Dark](#change-console-to-solarized-dark)
    - [Windows Font Install](#windows-font-install)
  - [More configuration sync](#more-configuration-sync)
    - [VS Code](#vs-code)
  - [Troubleshooting](#troubleshooting)
    - [PIP Errors](#pip-errors)
  - [Credits](#credits)
    - [Dotfiles](#dotfiles)
    - [Ansible Roles](#ansible-roles)
    - [Misc](#misc)
    - [Resources](#resources)

## Goal

> Make my life easier when setting up a machine.

## Prerequisites on an Ubuntu based machine

```bash
# Add Ansible and Git
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible git software-properties-common
```

## Prerequisites on an Arch based machine

```bash
# Add Ansible and Git
sudo pacman -Syu
sudo pacman -S ansible git

# Add Ansible AUR module
git clone https://github.com/cumpsd/ansible-aur.git ~/.ansible/plugins/modules/aur
```

## Setup an Ubuntu or Arch based machine

```bash
# Get the dotfiles
git clone --recurse-submodules https://github.com/cumpsd/dotfiles.git <your preferred location>/dotfiles
cd <your preferred location>/dotfiles

# Setup the system
./setup-system

# On Ubuntu, also run:
sudo ./install ubuntu

# On WSL, also run:
sudo ./install wsl

# If you want all .NET Core versions, also run:
sudo ./install dotnet

# At this point, it might be needed to explicitly run fisher and Oh My Fish! to get our shell setup
fish
fisher
omf install
fish_update_completions
```

## Setup all Git repos

```bash
# Import our existing GPG keys
gpg2 --import <key>

# Trust our imported key
gpg --edit-key user@domain.com

gpg> trust

Please decide how far you trust this user to correctly verify other users' keys
(by looking at passports, checking fingerprints from different sources, etc.)

  1 = I don't know or won't say
  2 = I do NOT trust
  3 = I trust marginally
  4 = I trust fully
  5 = I trust ultimately
  m = back to the main menu

Your decision? 5
And don't forget to save the changes:

gpg> save

# Unlock the dotfiles repo and setup all git repos
git-crypt unlock
./setup-repos

# Use SSH for remote
git remote set-url origin git@github.com:cumpsd/dotfiles.git
```

## Post Install steps on WSL

### Change Console to Solarized Dark

```bash
# Setup WSL specific tweaks
./setup-wsl
```

### Windows Font Install

- Download [Nerd Fonts Hack](https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/Hack.zip)
- Extract and install the required fonts (everything which ends with `Complete Mono Windows Compatible.ttf`)
- Set default console font to Hack NF, 14

## More configuration sync

### VS Code

- Install `shan.code-settings-sync`
- Press `Shift + Alt + D` it will ask your GitHub Gist ID.
- All VS Code settings are getting synced, whenever you change something you can upload them with `Shift + Alt + U` or turn on Auto-Upload with `Sync : Advanced Options > Toggle Auto-Upload on Settings Change`
- More info at https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync

## Troubleshooting

### PIP Errors

If the task `[pip : Ensure pip_install_packages are installed.]` is throwing errors looking like:

```plain
stderr: Traceback (most recent call last):
File \"/home/cumpsd/.local/bin/pip2\", line 7, in <module>
from pip import main
ImportError: cannot import name main\
```

You can fix it by running `python -m pip uninstall pip` and then executing `~/.dotfiles/setup-system` again.

## Credits

### Dotfiles

- [dotbot](https://github.com/anishathalye/dotbot) - A tool that bootstraps your dotfiles ⚡️

### Ansible Roles

| Role | Purpose |
| --- | --- |
| [ansible-role-docker](https://github.com/geerlingguy/ansible-role-docker) | Install Docker and Docker-compose |
| [ansible-role-dotnet-core](https://github.com/ocha/ansible-role-dotnet-core) | Install .NET Core |
| [ansible-fish](https://github.com/telus/ansible-fish) ([with modifications](https://github.com/cumpsd/ansible-role-fish)) | Install Fish and configure default shell |
| [ansible-fzf](https://github.com/dotstrap/ansible-fzf) | Install & configure fzf |
| [ansible-role-git](https://github.com/geerlingguy/ansible-role-git) | Install Git from source |
| [ansible-role-hub](https://github.com/wtanaka/ansible-role-hub) | Install Hub |
| [ansible-role-mono](https://github.com/cumpsd/ansible-role-mono) | Install Mono |
| [ansible-role-nodejs](https://github.com/geerlingguy/ansible-role-nodejs) | Install Node.js and NPM |
| [ansible-role-ntp](https://github.com/geerlingguy/ansible-role-ntp) | Setup NTP and configure timezone |
| [ansible-role-packer](https://github.com/geerlingguy/ansible-role-packer) | Install Packer |
| [ansible-role-pip](https://github.com/geerlingguy/ansible-role-pip) | Install Pip |
| [ansible-role-visual-studio-code](https://github.com/gantsign/ansible-role-visual-studio-code) | Install VS Code |

### Misc

| Where | What |
| --- | --- |
| [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) | The Fishshell Framework. |
| [fisherman](https://github.com/fisherman/fisherman) | The fish-shell plugin manager. |
| [theme-bobthefish](https://github.com/oh-my-fish/theme-bobthefish) | A Powerline-style, Git-aware fish theme optimized for awesome. |
| [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) | Iconic font aggregator, collection, and patcher. |
| [dircolors-solarized](https://github.com/seebi/dircolors-solarized/) | Solarized dircolors. |
| [git-crypt](https://github.com/AGWA/git-crypt) | Transparent file encryption in git. |
| [thefuck](https://github.com/nvbn/thefuck) | Magnificent app which corrects your previous console command. |
| [GNU Privacy Guard](https://gnupg.org/) | All things encryption. |

### Resources

| Where | What |
| --- | --- |
| [Increasing development productivity with repository management](https://blog.kalis.me/increasing-development-productivity-repository-management/) | System to easily manage repositories. |
