# vim -- Vi IMproved, a programmers text editor
{:data-section="shell"}
{:data-date="April 16, 2019"}
{:data-extra="Um Pages"}


## Find & replace for accross multiple files
``:args `grep -r -l 'foo' src```
: Populate args with the files that have the thing being replaced.

`fd blah | xargs vim`
: Populate args when starting vim.

`rg -l "@Test" | xargs vim`
: Same as above

`:args`
: Verify the list looks okay, i.e. no build files or git files in there.

`:argdo %s/@Test/\/\/@Test/g | update`
: Do the replacement. Pipes run additional commands. You generally have to write at the end because
otherwise vim won't move on to the next file.

`:argdo /\/\/@Test/s//@Test public void noopForDisablingTests() {}\r\/\/@Test/ | update`
: Similar to above—replaces just the first instance of \\@Test with a noop test.

`:argdo execute 'normal o@SetThreadLocalContext' | w`
: Do some normal mode stuff.

## Macros

`qa i//<esc> q`
: Record a macro into register a that inserts two forward slashes.

`:5,10norm! @a`
: Play the macro in register a on lines 5 through 10.

## Other

`V9G`
: Enter visual mode, with the lines from current to line 9 selected.


