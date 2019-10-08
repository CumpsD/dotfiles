# Start or re-use a gpg-agent.

gpgconf --launch gpg-agent

if test -e ~/.gnupg/S.gpg-agent.ssh
    set -gx SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh
end

if test -e /run/user/1000/gnupg/S.gpg-agent.ssh
    set -gx SSH_AUTH_SOCK /run/user/1000/gnupg/S.gpg-agent.ssh
end

set -gx GPG_TTY (tty)

gpg-connect-agent updatestartuptty /bye > /dev/null

chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg/private-keys-v1.d/

#dbus-update-activation-environment --systemd DISPLAY 2> /dev/null

# keybase list-following; keybase pgp pull
