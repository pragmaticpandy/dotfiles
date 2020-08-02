#!/usr/bin/env zsh

panserver () {
        rm -rf $1/build
        port=$((1024 + RANDOM))
        host=$(hostname)
        echo Click: http://"$host":"$port" or http://localhost:"$port"
        python3 ~/installs/panserver/panserver.py -a -r -p $port $@
}



