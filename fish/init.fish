# Note: Bash on Windows does not currently apply umask properly.
if [ (umask) = "0000" ]; umask 022; end

# Export our Display to get it into Windows
set -gx DISPLAY :0

# Set a default editor
set -gx EDITOR nano

# Tweak some environment variables
set -gx GOPATH $HOME/go 2> /dev/null
set PATH $GOPATH/bin /usr/local/go/bin $PATH 2> /dev/null

# OMF Settings
set -gx OMF_REPO_URI "https://github.com/cumpsd/oh-my-fish"

# Bobthefish theme settings
set -g theme_title_display_process yes
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized-dark
set -g theme_date_format "+%a %F // %R"
set -g theme_display_ruby no
set -g theme_display_user ssh
set -g theme_display_hostname ssh

# Configure Docker to use Docker for Windows
set -gx DOCKER_HOST tcp://0.0.0.0:2375

# Configure new keybindings for fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# Disable .NET telemetry
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1

# Map hub to git for TheFuck
eval (hub alias -s)
set -x THEFUCK_OVERRIDDEN_ALIASES 'git'

# Start GnuPG-agent
. ~/.config/fish/gnupg.fish

# Start in home directory
cd ~
