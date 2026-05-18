" vim-plug plugin manager
set nocompatible
" alias Plugin -> Plug，使 plugins_list.vim 对两个管理器通用
command! -nargs=+ Plugin Plug <args>
call plug#begin('~/.vim/plugged')
source ~/.vim/vimrcs/plugins_list.vim
call plug#end()
" filetype plugin indent on 这一行就等于依次执行了：
" - filetype on（侦测文件类型）
" - filetype plugin on（加载文件类型插件）
" - filetype indent on（加载缩进规则）
filetype plugin indent on
