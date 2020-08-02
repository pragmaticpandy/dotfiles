#!/usr/bin/env zsh

alias get-killed-reason="dmesg | grep -E -i -B100 'killed process'"

# Translate dmesg timestamps to human readable format
# https://blog.sleeplessbeastie.eu/2013/10/31/how-to-deal-with-dmesg-timestamps/
dmesg-h(){

    # desired date format
    date_format="%a %b %d %T %Y"

    # uptime in seconds
    uptime=$(cut -d " " -f 1 /proc/uptime)

    # run only if timestamps are enabled
    if [ "Y" = "$(cat /sys/module/printk/parameters/time)" ]; then
      dmesg | sed "s/^\[[ ]*\?\([0-9.]*\)\] \(.*\)/\\1 \\2/" | while read timestamp message; do
        printf "[%s] %s\n" "$(date --date "now - $uptime seconds + $timestamp seconds" +"${date_format}")" "$message"
      done
    else
      echo "Timestamps are disabled (/sys/module/printk/parameters/time)"
    fi
}


