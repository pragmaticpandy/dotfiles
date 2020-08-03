#!/usr/bin/env zsh

pluginDir="$(dirname "${(%):-%x}")"
for f in "$pluginDir"/sourced_zsh/*; do
    source $f
done


