# Start or re-use a gpg-agent.

gpgconf --launch gpg-agent
set -gx SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh
set -gx GPG_TTY (tty)

gpg-connect-agent updatestartuptty /bye > /dev/null

chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg/private-keys-v1.d/

# keybase list-following; keybase pgp pull
