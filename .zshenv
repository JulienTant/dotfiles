# Set PATH so it includes user's private bin directories
PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"
MANPATH="${HOME}/.local/share/man:${MANPATH}"

# required for gpg-agent
export GPG_TTY=$(tty)


# notmuch
export NOTMUCH_CONFIG=$HOME/.config/notmuch/default/config

# Bitwarden
if [ -f "$HOME/.bitwarden_session" ]; then
    source "$HOME/.bitwarden_session"
fi


#nvm
source /usr/share/nvm/init-nvm.sh


#go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export GOPROXY=https://goproxy.io,direct


export BROWSER=brave
export EDITOR="emacsclient -t -a emacs"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode


export PATH=$HOME/.config/emacs/bin:$PATH

# remove duplicates in PATH
typeset -U path

source ~/.aliases
