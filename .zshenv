# general env var
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

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
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
source /usr/share/nvm/init-nvm.sh
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc



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
