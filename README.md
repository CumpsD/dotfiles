# @cumpsd • dotfiles

## Setup a new machine

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible software-properties-common git

git clone https://github.com/cumpsd/dotfiles.git ~/.dotfiles
~/.dotfiles/playbooks/setup
```
