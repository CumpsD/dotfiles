# @cumpsd • dotfiles

## Setup a new machine

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible software-properties-common git

git clone --recurse-submodules -j8 https://github.com/cumpsd/dotfiles.git ~/.dotfiles
~/.dotfiles/setup-system
```

## Credits

### Dotfiles

* https://github.com/anishathalye/dotbot - A tool that bootstraps your dotfiles ⚡️

### Ansible Roles

* https://github.com/geerlingguy/ansible-role-git
* https://github.com/geerlingguy/ansible-role-pip
* https://github.com/geerlingguy/ansible-role-nodejs
* https://github.com/geerlingguy/ansible-role-docker
* https://github.com/geerlingguy/ansible-role-packer
* https://github.com/geerlingguy/ansible-role-ntp
* https://github.com/ocha/ansible-role-dotnet-core
