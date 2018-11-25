# @cumpsd • dotfiles

## Setup a new machine

```bash
# Add Ansible and Git
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible git software-properties-common

# Get the dotfiles
git clone --recurse-submodules -j8 https://github.com/cumpsd/dotfiles.git <your preferred location>/dotfiles
cd <your preferred location>/dotfiles

# Link as much as we can already
./install
sudo -u cumpsd ./install
sudo ./install

# Do an initial run which sets up a lot of dependencies
pushd ansible > /dev/null
ansible-playbook -K -i inventory system.yml
popd > /dev/null

# Install git-crypt
mkdir /tmp/git-crypt
tar -xzf git/git-crypt-0.6.0.tar.gz -C /tmp/git-crypt --strip 1
cd /tmp/git-crypt
make
sudo cp git-crypt /usr/local/bin/

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

# Unlock the repo and setup the system
git-crypt unlock
./setup-system

# Use SSH for remote
git remote set-url origin git@github.com:cumpsd/dotfiles.git

# At this point, it might be needed to explicitly run fisher and Oh My Fish! to get our shell setup
fisher
omf install
```

## Post Install steps on WSL

### Font Install

* Download https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/Hack.zip
* Extract and install the required fonts (everything which ends with `Complete Mono Windows Compatible.ttf`)
* Set default console font to Hack NF, 14

### X Server Install

* Install https://github.com/CumpsD/dotfiles/raw/master/wsl/vcxsrv-64.1.20.0.0.installer.exe
* Download https://raw.githubusercontent.com/CumpsD/dotfiles/master/wsl/X.lnk, save it somewere and edit the path

## More configuration sync

### VS Code

* Install `shan.code-settings-sync`
* Press `Shift + Alt + D` it will ask your GitHub Gist ID.
* All VS Code settings are getting synced, whenever you change something you can upload them with `Shift + Alt + U` or turn on Auto-Upload with `Sync : Advanced Options > Toggle Auto-Upload on Settings Change`
* More info at https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync

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

### ebtables on WSL with Ubuntu 18.04

When doing an `apt-get dist-upgrade` on Ubuntu Bionic, it will fail on `ebtables` due to https://github.com/Microsoft/WSL/issues/3274

You can fix it by running `sudo apt-mark hold ebtables` and then executing `~/.dotfiles/setup-system` again.

## Credits

### Dotfiles

* https://github.com/anishathalye/dotbot - A tool that bootstraps your dotfiles ⚡️

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
