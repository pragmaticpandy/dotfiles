#!/usr/bin/env zsh

install-panserver() (
	set -e
	echo Installing panserver...
	mkdir -p ~/installs
	brew install python
	rm -rf ~/installs/panserver
	git clone https://github.com/pragmaticpandy/panserver.git ~/installs/panserver
	sudo pip3 install bottle
	brew install pandoc
	echo Done.
)

install-pathogen() (
	set -e
	echo Intalling pathogen...
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
	echo Done.
)

# Requires pathogen
install-gruvbox() (
	set -e
	echo Installing gruvbox...
	git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
	echo Done.
)

install-dotfiles() (
	echo Installing dotfiles...
	dotfiles_dir="$(dirname "$(dirname "${(%):-%x}")")"/dotfiles

	# For every dot file in dot-files, link from the ~/FILENAME to the dot file.
	for p in "$dotfiles_dir"/*(D); do

	    # ! means we want to link a specific file under a directory instead of the
	    # entire directory. So here to create the link path we replace the !s with
	    # forward slashes
	    link=$(echo ~/$p:t |sed -e "s/\!/\//g")

	    echo Linking $link to $p
	    if [[ -h $link ]]; then
		echo Existing $link is a symlink to $(readlink $link). Removing it...
		unlink $link
	    elif [[ -a $link ]] || [[ -d $link ]]; then
		old_dest=/tmp/$p:t-old-$RANDOM
		echo Moving existing $link to $old_dest
		mv $link $old_dest
	    fi

	    mkdir -p $(dirname "$link")
	    ln -s $p $link
	    echo Done.
	done

	echo Done with all links.
)

# necessary to enable python 2 support
install-vim() (
    sudo echo Installing vim...
    brew install python
    mkdir -p ~/installs
    (
        set -e
        cd ~/installs
        rm -rf vim
        git clone https://github.com/vim/vim.git
        cd vim
        make distclean
        ./configure --enable-pythoninterp --enable-python3interp
        make
        sudo make install
    )

    echo Done.
)
