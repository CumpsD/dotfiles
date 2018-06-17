# @cumpsd • dotfiles

## Setup a new machine

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible software-properties-common git

git clone --recurse-submodules -j8 https://github.com/cumpsd/dotfiles.git ~/.dotfiles
~/.dotfiles/setup-system
```

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

* https://github.com/geerlingguy/ansible-role-git
* https://github.com/geerlingguy/ansible-role-pip
* https://github.com/geerlingguy/ansible-role-nodejs
* https://github.com/geerlingguy/ansible-role-docker
* https://github.com/geerlingguy/ansible-role-packer
* https://github.com/geerlingguy/ansible-role-ntp
* https://github.com/ocha/ansible-role-dotnet-core
* https://github.com/cumpsd/ansible-role-mono
* https://github.com/gantsign/ansible-role-visual-studio-code
* https://github.com/telus/ansible-fish (with modifications at https://github.com/cumpsd/ansible-role-fish)
