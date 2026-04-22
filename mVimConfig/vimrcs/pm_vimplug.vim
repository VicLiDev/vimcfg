" vim-plug plugin manager
set nocompatible
" alias Plugin -> Plug，使 plugins_list.vim 对两个管理器通用
command! -nargs=+ Plugin Plug <args>
call plug#begin('~/.vim/plugged')
source ~/.vim/vimrcs/plugins_list.vim
call plug#end()
filetype plugin indent on
