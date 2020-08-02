# ln -- make links
{:data-section="shell"}
{:data-date="April 16, 2019"}
{:data-extra="Um Pages"}

## SYNOPSIS
ln [-s] source target

## DESCRIPTION
Target points to source. The source path is relative, so usually you want to provide a full path.

A hard link references the contents of the original file, so it will still be readable if the source
file is deleted or moved. On the other hand, symbolic links just contain the path to the source file,
and thus will be broken if the source is moved or deleted. Generally, you must use symbolic links for
directories or links across file systems.

## OPTIONS
`-s`
: Create a symbolic link instead of a hard link.

