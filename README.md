## Deactivate flow control (ctrl s)
Put this in .bashrc

    stty -ixon


## Remapping Caps Lock
### Ubuntu
Run

    dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

## Time zone change
While traveling, the time zone can be changed like this:

    timedatectl set-timezone Europe/Paris

## Setting up mail
Install:
   - neomutt
   - notmuch
   - notmuch-mutt
   - msmtp
   - offlineimap

From other computer:
   - Import GPG Keys
   - Copy folder with encrypted passwords
   - Copy ~/.mailboxes with default mailboxes

### Encrypt passwords
   - Encrypt: gpg -c > ~/.kak/hallo.gpg
   - Decrypt: gpg --no-tty -q -d ~/.kak/hallo.gpg

