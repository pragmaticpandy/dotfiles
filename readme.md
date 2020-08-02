## Setup steps
1. Import iterm2 key mappings (in resources dir).
1. Copy from `resources/.zshrc` into `~/.zshrc`, or just symlink it to use as-is.
1. Setup [GitHub ssh] and then add something like the following to `~/.ssh/config`:
   ```
   host github.com
       HostName github.com
       IdentityFile ~/.ssh/id_rsa_github
       IdentitiesOnly yes
   ```

[GitHub ssh]: https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
