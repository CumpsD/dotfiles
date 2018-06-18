# @cumpsd • dotfiles

## Setup a new machine

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible software-properties-common git

git clone --recurse-submodules -j8 https://github.com/cumpsd/dotfiles.git ~/.dotfiles
~/.dotfiles/setup-system
```

## Post Install steps on WSL

### Font Install

* Download https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/Hack.zip
* Extract and install the required fonts (everything which ends with `Complete Mono Windows Compatible.ttf`)
* Set default console font to Hack NF, 14

### X Server Install

* Install https://github.com/CumpsD/dotfiles/raw/master/wsl/vcxsrv-64.1.20.0.0.installer.exe
* Download https://raw.githubusercontent.com/CumpsD/dotfiles/master/wsl/X.lnk, save it somewere and edit the path
* Download https://raw.githubusercontent.com/CumpsD/dotfiles/master/wsl/terminator.vbs and save it somewhere
* Download https://raw.githubusercontent.com/CumpsD/dotfiles/master/wsl/Terminator.lnk, save it somewhere and edit the path

## Troubleshooting

### PIP Errors

If the task `[pip : Ensure pip_install_packages are installed.]` is throwing errors looking like:

```
stderr: Traceback (most recent call last):
File \"/home/cumpsd/.local/bin/pip2\", line 7, in <module>
from pip import main
ImportError: cannot import name main\
```

You can fix it by running `python -m pip uninstall pip` and then executing `~/.dotfiles/setup-system` again.

## Credits

### Dotfiles

* https://github.com/anishathalye/dotbot - A tool that bootstraps your dotfiles ⚡️

### Ansible Roles

| Role | Purpose |
| --- | --- |
| [ansible-role-git](https://github.com/geerlingguy/ansible-role-git) | Install Git from source |
| [ansible-role-pip](https://github.com/geerlingguy/ansible-role-pip) | Install Pip |
| [ansible-role-nodejs](https://github.com/geerlingguy/ansible-role-nodejs) | Install Node.js and NPM |
| [ansible-role-docker](https://github.com/geerlingguy/ansible-role-docker) | Install Docker and Docker-compose |
| [ansible-role-packer](https://github.com/geerlingguy/ansible-role-packer) | Install Packer |
| [ansible-role-dotnet-core](https://github.com/ocha/ansible-role-dotnet-core) | Install .NET Core |
| [ansible-role-mono](https://github.com/cumpsd/ansible-role-mono) | Install Mono |
| [ansible-role-visual-studio-code](https://github.com/gantsign/ansible-role-visual-studio-code) | Install VS Code |
| [ansible-fish](https://github.com/telus/ansible-fish) ([with modifications](https://github.com/cumpsd/ansible-role-fish)) | Install Fish and configure default shell |
| [ansible-role-ntp](https://github.com/geerlingguy/ansible-role-ntp) | Setup NTP and configure timezone |

### Misc

| Where | What |
| --- | --- |
| [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) | The Fishshell Framework. |
| [theme-bobthefish](https://github.com/oh-my-fish/theme-bobthefish) | A Powerline-style, Git-aware fish theme optimized for awesome. |
| [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) | Iconic font aggregator, collection, and patcher. |
| [dircolors-solarized](https://github.com/seebi/dircolors-solarized/) | Solarized dircolors. |
