# Note: Bash on Windows does not currently apply umask properly.
if [ (umask) = "0000" ]; umask 022; end

# Export our Display to get it into Windows
set -gx DISPLAY :0

# Set a default editor
set -gx EDITOR nano

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
