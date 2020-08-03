#!/usr/bin/env zsh

pluginDir="$(dirname "${(%):-%x}")"
echo $pluginDir
for f in "$pluginDir"/sourced_zsh/*; do
    source $f
done


