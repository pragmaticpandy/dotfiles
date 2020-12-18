#!/usr/bin/env bash

alias get-current-seconds="date +%s"

from-seconds() {
    date -d @"$1"
}

# uses same format as from-seconds
to-seconds() {
    date -j -f '%a, %d %b %Y %T %z' $1 +%s
}

# date formatted as YYYY-MM-DD
d(){
    TZ=America/Los_Angeles date +%Y-%m-%d
}

