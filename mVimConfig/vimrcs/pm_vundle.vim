" Vundle plugin manager
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
source ~/.vim/vimrcs/plugins_list.vim
call vundle#end()
" filetype plugin indent on 这一行就等于依次执行了：
" - filetype on（侦测文件类型）
" - filetype plugin on（加载文件类型插件）
" - filetype indent on（加载缩进规则）
filetype plugin indent on
