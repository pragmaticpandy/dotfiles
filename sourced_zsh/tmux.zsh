#!/usr/bin/env zsh

# Make tmux socket location not tmp.
alias tmux='tmux -S ~/.tmux-sockets'

alias ta='tmux attach'

# "tn foo" would create a new session with the name in the format of YYYY-MM-DD-foo
tn(){
    tmux new -s $(TZ=America/Los_Angeles date +%Y-%m-%d)-$1
}


