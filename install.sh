#!/bin/bash

mv $HOME/.vimrc $HOME/.vimrc_org
ln -s `pwd`/vimrc $HOME/.vimrc

mv $HOME/.vim $HOME/.vim_old
ln -s `pwd`/vim $HOME/.vim

mv $HOME/.bashrc $HOME/.bashrc_old
ln -s `pwd`/bashrc $HOME/.bashrc

# Create symlinks to bash include files
ln -s `pwd`/bash_functions $HOME/.bash_functions
ln -s `pwd`/bash_aliases $HOME/.bash_aliases
ln -s `pwd`/bash_private $HOME/.bash_private
ln -s `pwd`/gitconfig $HOME/.gitconfig
ln -s `pwd`/screenrc $HOME/.screenrc

# source the changes
. ~/.bashrc

# init and update submodules
git submodule init && git submodule update
if (( $? )) ; then echo init and update failed ; else echo Install complete; fi
