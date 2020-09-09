set number
set backspace=2
set tabstop=4
set shiftwidth=4
set expandtab
syntax enable
set hlsearch
set autoindent
set colorcolumn=100

"
" appearance
"
autocmd FileType * colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'

" Make background actually black
autocmd FileType * hi Normal ctermbg=0
" Make line numbers a tad darker
autocmd FileType * hi LineNr ctermfg=237

" Make lines break automatically
autocmd FileType tex,latex,markdown,ruby,java set tw=100
autocmd Filetype gitcommit set tw=72
autocmd FileType java set fo-=t " Only auto-wrap comments in Java

" Spell check
autocmd Filetype markdown,tex,gitcommit,java call SetupSpellCheck()
function SetupSpellCheck()
    set spell
    set spellcapcheck=false
    syn match url '\[\=\w\+:\/\/[^[:space:]]\+\]\=' contains=@NoSpell
    syn match camelCase '\u\=\l\+\(\u\l\+\)\+' contains=@NoSpell
    syn match allCaps '\u\u\+s\=' contains=@NoSpell

endfunction

autocmd Filetype gitcommit set colorcolumn=50,72

" fix colors in tmux
set background=dark
set t_Co=256

" show bad whitespace
autocmd FileType * highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

fun! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun

fun! SortImports()
    " Save original cursor position.
    let l:winview = winsaveview()

    " Move cursor to the top.
    call cursor(1, 1)

    " Get the line number of the first import
    let firstImportLineNum = search('^import')

    " return early if no imports (firstImportLineNum = 0)
    if firstImportLineNum == 0
        call winrestview(l:winview)
        return
    endif

    let nextImportLineNum = firstImportLineNum
    let previousImportLineNum = nextImportLineNum - 1
    while nextImportLineNum == previousImportLineNum + 1
        let previousImportLineNum = nextImportLineNum
        let nextImportLineNum = search('^import')
    endwhile

    " Do the sort.
    execute firstImportLineNum . "," . previousImportLineNum "sort u"

    " Reset cursor position to its original.
    call winrestview(l:winview)
endfun

" Run SortImports before saving.
:autocmd BufWritePre *.java call SortImports()

" write 'package' at the beginning of a line and this will auto-fill it
fun! InsertPackageName()
    " Save original cursor position.
    let l:winview = winsaveview()

    " Move cursor to the top.
    call cursor(1, 1)

    let firstLineNumStartingWithPackage = search('^package')

    if firstLineNumStartingWithPackage == 0
        call winrestview(l:winview)
        return
    endif

    let path = expand('%:p:h')
    let indices = [strridx(path, '/src/'), strridx(path, '/tst/')]
    let indexOfSourceDir = max(indices)

    if indexOfSourceDir < 0
        call winrestview(l:winview)
        return
    endif

    let subPath = strpart(path, indexOfSourceDir + 5)
    let packageName = substitute(subPath, '/', '.', 'g')

    " Delete the line and replace it with the package name.
    :execute "normal! ddipackage" packageName . ";\n"

    " Reset cursor position to its original.
    call winrestview(l:winview)
endfun

" Run InsertPackageName before saving .java files.
:autocmd BufWritePre *.java call InsertPackageName()

" Searches current code project that you're working in for imports matching the class name provided.
fun! AddImport(className)
    " Save original cursor position.
    let l:winview = winsaveview()

    let path = expand('%:p:h')
    let indices = [strridx(path, '/src/'), strridx(path, '/tst/')]
    let indexOfSourceDir = max(indices)

    if indexOfSourceDir < 0
        echo "Could not determine package root."
        call winrestview(l:winview)
        return
    endif

    let packageDir = strpart(path, 0, indexOfSourceDir)

    let matchesString = system('grep -hr --include "*.java" "^import.*\.' . a:className . ';$" ' . packageDir . ' | sort -u')
    let matchesList = split(matchesString, "\n")

    if len(matchesList) == 0
        echo 'No matches found.'
        call winrestview(l:winview)
        return
    endif

    " Print the matches with their index.
    let c = 0
    for match in matchesList
        echo c . ' ' . match
        let c += 1
    endfor

    call inputsave()
    let selection = input('Type selection number or hit return to cancel: ')
    call inputrestore()

    " Exit if selection isn't a number or is blank.
    if selection =~ '\D' || selection == ''
        call winrestview(l:winview)
        return
    endif

    " Exit if selection is outside range.
    let selectionIndex = str2nr(selection)
    if selectionIndex < 0 || selectionIndex >= len(matchesList)
        call winrestview(l:winview)
        return
    endif

    " Move cursor to the top.
    call cursor(1, 1)

    " Get the line number of the first import
    let firstImportLineNum = search('^import')

    " return early if no imports (firstImportLineNum = 0)
    if firstImportLineNum == 0
        echo 'No imports yet, so I do not know where to insert. Add one import, then try again.'
        call winrestview(l:winview)
        return
    endif

    :execute 'normal! o' . matchesList[selectionIndex]

    call SortImports()

    " Reset cursor position to its original.
    call winrestview(l:winview)
endfun

" Alias AddImport so that it can be called like 'I NonNull'
command! -nargs=1 I call AddImport(<q-args>)

fun! TurnOnAutoSave()
    augroup AutoSave
    autocmd TextChanged,TextChangedI <buffer> silent write
    augroup END
endfun

fun! TurnOffAutoSave()
    :autocmd! AutoSave
endfun

" pathogen for plugins
" More info: https://github.com/tpope/vim-pathogen
execute pathogen#infect()

