# Note: Bash on Windows does not currently apply umask properly.
if [ (umask) = "0000" ]; umask 022; end

# Export our Display to get it into Windows
set -gx DISPLAY :0

# Pick the correct VA-API driver
set -gx LIBVA_DRIVER_NAME iHD

# Set a default editor
set -gx EDITOR nano

# Tweak some environment variables
set -gx GOPATH $HOME/go 2> /dev/null
set PATH $GOPATH/bin /usr/local/go/bin $PATH 2> /dev/null
set PATH $PATH (gem env gempath | sed 's/:/\/bin\/:/g' | string split : --) 2> /dev/null
set PATH $PATH /opt/mssql-tools/bin/ 2> /dev/null
set PATH $PATH /usr/local/lib/npm/bin 2> /dev/null

# Add .NET Core to PATH
set PATH $PATH /usr/share/dotnet 2> /dev/null

# OMF Settings
set -gx OMF_REPO_URI "https://github.com/cumpsd/oh-my-fish"

# Bobthefish theme settings
set -g theme_title_display_process yes
set -g theme_color_scheme solarized-dark
set -g theme_date_format "+%a %F // %R"
set -g theme_display_ruby no
set -g theme_display_user ssh
set -g theme_display_hostname ssh

if tty | grep /dev/tty > /dev/null
    if cat /proc/version | grep Microsoft > /dev/null
        set -g theme_nerd_fonts yes
    else
        set -g theme_nerd_fonts no
        set -g theme_color_scheme terminal-light
    end
else
    set -g theme_nerd_fonts yes
end

# Small tweak to autocomplete colors
set -g fish_color_autosuggestion 555 yellow brblack

# Make bspwm work with fish
set -U SXHKD_SHELL /usr/bin/bash

# Make java work bith bspwm
set -U _JAVA_AWT_WM_NONREPARENTING 1
wmname LG3D

# Configure Docker to use Docker for Windows
set -gx DOCKER_HOST tcp://0.0.0.0:2375

# Configure new keybindings for fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# Disable .NET telemetry
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1

# Configure Python3
set -gx WORKON_HOME $HOME/.virtualenvs                    # Environments stored here
set -gx PROJECT_HOME $HOME/.dotfiles/repos/python         # Path to your Python projects
set -gx VIRTUALENVWRAPPER_PYTHON /usr/bin/python3         # Make Python3 the default
# bash /usr/local/bin/virtualenvwrapper.sh                  # Engage!
# eval (python3 -m virtualfish auto_activation projects)

set PATH $PATH (python3 -m site --user-base)/bin 2> /dev/null

# Map hub to git for TheFuck
eval (hub alias -s)
set -x THEFUCK_OVERRIDDEN_ALIASES 'git'

# Start GnuPG-agent
. ~/.config/fish/gnupg.fish

# Run Private tweaks
. ~/.config/fish/init-private.fish

# Load in Nerd Fonts
for i in ~/.local/share/fonts/i_{dev,fae,fa,iec,linux,oct,ple,pom,seti,material,weather}.sh
    . "$i"
end

# Start in home directory
cd ~
