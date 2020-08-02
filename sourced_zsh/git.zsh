#!/usr/bin/env zsh

# git diff
gd() {
    git diff --color=always "$@" | less -R
}

# git diff --cached
gdc() {
    gd --cached "$@"
}

# git status
g() {
    clear && git status
}

# Use instead of git log or git graph.
# matching *ma* remotes is a hack to get mainline and master but hopefully not others.
gg() (
    git log --graph --abbrev-commit --decorate --date=relative \
    --format=format:'%C(white)%h%C(reset) - %C(green    )(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' \
    --branches='*' \
    --remotes='origin/*ma*'
)
