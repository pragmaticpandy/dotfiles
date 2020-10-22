# git -- the stupid content tracker
{:data-section="shell"}
{:data-date="October 22, 2020"}
{:data-extra="Um Pages"}

## SYNOPSIS
Bisect

~~~
#!/usr/bin/env zsh

set -euo pipefail

git bisect start

# first we need to set one new and old commit. old in this example means it has RawObject.java

git bisect new mainline # tip of mainline is new, i.e. missing RawObject.java

git bisect old c6bc1301 # very old commit that has RawObject

# just using a find shell command to test, though swapping 1 and 0 result of word count

# good/old commits should print 0

git bisect run zsh -c 'exit $(( ( $(fd -E build -H -I "rawobject.java" . | wc -l) + 1 ) % 2 ))'

# HEAD should be the most recent old commit, so we exit bisect and stay there

# could also do bisect/new instead of HEAD to checkout the first new commit

git bisect reset HEAD
~~~

## DESCRIPTION


## OPTIONS

