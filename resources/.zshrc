#!/usr/bin/env zsh

ANTIGEN_LOG=/tmp/antigen.log

mkdir -p ~/installs
if [[ ! -a ~/installs/antigen.zsh ]]; then
    curl -L https://raw.githubusercontent.com/pragmaticpandy/antigen/master/bin/antigen.zsh > ~/installs/antigen.zsh
fi
source ~/installs/antigen.zsh

antigen bundle ~/personal-workspaces/dotfiles --no-local-clone
antigen bundle https://github.com/pragmaticpandy/pragmaticprompt.git

antigen apply

