#!/usr/bin/env zsh

pluginDir="$(dirname $0:A)"
for f in "$pluginDir"/sourced_zsh/*; do
    source $f
done


