" Vundle plugin manager
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source ~/.vim/vimrcs/plugins_list.vim
call vundle#end()
filetype plugin indent on
