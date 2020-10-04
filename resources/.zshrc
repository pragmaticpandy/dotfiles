#!/usr/bin/env zsh

ANTIGEN_LOG=/tmp/antigen.log

mkdir -p ~/installs
if [[ ! -a ~/installs/antigen.zsh ]]; then
    curl -L https://raw.githubusercontent.com/pragmaticpandy/antigen/master/bin/antigen.zsh > ~/installs/antigen.zsh
fi
source ~/installs/antigen.zsh

antigen bundle https://github.com/pragmaticpandy/dotfiles.git
antigen bundle https://github.com/pragmaticpandy/pragmaticprompt.git
antigen bundle https://github.com/pragmaticpandy/serviz.git

if [[ -a ~/.ssh/id_rsa_github ]]; then
    antigen bundle ssh://git@github.com/pragmaticpandy/privatedotfiles.git
fi

antigen apply

# Use homebrew for coreutils
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  # gnubin; gnuman
  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done
fi

export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"


