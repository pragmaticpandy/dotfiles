#!/usr/bin/env zsh

__print_all_colors(){
    big=$1
    little=$2

    for big_i in {0..255}; do
        for little_i in {231..232}; do
            printf \
                "\e[%s;5;%sm\e[%s;5;%sm[%s;5;%sm[%s;5;%sm\e[0m" \
                $big $big_i $little $little_i \
                $big $big_i $little $little_i

        done

        echo
    done
}

print-all-fg-colors() {
    __print_all_colors 38 48
}

print-all-bg-colors() {
    __print_all_colors 48 38
}

