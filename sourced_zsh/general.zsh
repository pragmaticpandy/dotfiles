#!/usr/bin/env bash

# vi bindings. do this up top so custom bindings don't gen overwritten by bindkey -v
EDITOR="$(which vim)"
VISUAL="$(which vim)"
bindkey -v

# history and backsearch.
export HISTFILE=~/.history
export HISTSIZE=16000
export SAVEHIST=15000
bindkey '^R' history-incremental-search-backward

# quick edit and source .zshrc
alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"

alias e="exit"
alias l="ls -alh --ignore='.DS_Store'"
alias lt="ls -alrth"
alias v="vim"
alias vi="vim"
alias t="tail -f -n +1"
alias get-used-ports="sudo lsof -i -P -n | grep LISTEN"

# Get running tasks by command name. Usage: top-by-command blah
top-by-command() {
    top -c -p $(pgrep -d',' -f $1)
}

# find a file
# f <term> [dir]
f(){
    if (( $# == 1 )); then dir=.;
    elif (( $# == 2)); then dir=$2;
    else echo "Wrong number of arguments. Usage: f <pattern> [directory]"; return 1; fi
    typeset -A files
    echo "Friendly reminder that the existence of uppercase letters in the input will make the search case sensitive.";
    echo "command is 'fd -E build -H -I \"$1\" $dir'"
    echo
    files="$(fd -E build -H -I "$1" $dir)"
    if [ -z "$files" ]; then return 0; fi
    count=0
    while read -r line; do
        let count=count+1
        echo $line $count
    done <<< "$files"
    echo
    echo Make selection or press enter to quit:
    read selection
    if [ -z "$selection" ]; then return 0; fi
    let count=0
    while read -r line; do
        let count=count+1
        if (( $selection == $count )); then
            vim $line < /dev/tty;
            return 0;
        fi
    done <<< "$files"
}

# search java files
# js <term> [dir]
sag(){
    typeset -A files
    files="$(rg --hidden --follow --ignore-case --files-with-matches "$@")"
    if [ -z "$files" ]; then return 0; fi
    rg --hidden --follow --ignore-case "$@"
    printf "\n"
    count=0;
    while read -r line; do
        let count=count+1
        echo $line $count
    done <<< "$files"
    echo Make selection or press enter to quit:
    read selection
    if [ -z "$selection" ]; then return 0; fi
    let count=0
    while read -r line; do
        let count=count+1
        if (( $selection == $count )); then
            vim $line < /dev/tty;
            return 0;
        fi
    done <<< "$files"
}

# REPL cd
c(){
    count=0;
    for f in */; do
        let count=count+1
        echo $f $count
    done
    echo Make selection or press enter to quit:
    read selection
    if [ -z "$selection" ]; then return 0; fi
    let count=0
    for f in */; do
        let count=count+1
        if (( $selection == $count)); then
            cd $f;
            return 0;
        fi
    done
}


