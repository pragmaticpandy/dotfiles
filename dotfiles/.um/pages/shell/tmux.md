# tmux -- terminal multiplexer
{:data-section="shell"}
{:data-date="April 16, 2019"}
{:data-extra="Um Pages"}

## Description
Commands can be invoked in a few ways:

* By running ```tmux```.
* By using the escape sequence, then pressing ```:```, then typing a command.
* By using the escape sequence, then pressing hotkeys.

The references below will be prefixed with ```tmux``` for the first case, ```:``` for the second,
and nothing for the third.

## Sessions
`tmux new -s <session name> -n <window name>`
: Create a new session.

`$`
: Rename session.

`:kill-session`
: Kill session.

`d`
: Detach from session.

## Windows & Panes
`%`
: Create a new pane, splitting the current pane horizontally.

`!`
: Send pane to new window. This is the most useful way to create a new window.

`w`
: List windows.

`n`
: Go to next window.

`p`
: Go to previous window.

`,`
: Rename window.

`&`
: Kill window.

`:joinp -ht <window index>.<pane index>`
: Send current pane to the target pane, splitting it horizontally.

`esc 1`
: Arrange panes horizontally.

## Save console output
use prefix + :, then type in capture-pane -S -3000 + return (Replace 3000 with however many lines
you'd like to save.) This copies those lines into a buffer.

Then, to save the buffer to a file, just use prefix + : again, and type in save-buffer filename.txt
+ return, replacing filename with whatever you'd like.


