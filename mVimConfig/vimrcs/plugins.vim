" ========================================================================================== vim-plug config
" vim-plug: Vim plugin manager
" ============================
"
" Download plug.vim and put it in ~/.vim/autoload
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Edit your .vimrc
"
" call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" ================================ my plugin begin
" Plug 'preservim/nerdtree'
" Plug 'mhinz/vim-startify'
" Plug 'kien/ctrlp.vim'
" Plug 'Valloric/YouCompleteMe'
" Plug 'vim-scripts/taglist.vim'

" ================================ my plugin end

" Initialize plugin system
" call plug#end()
"
" Then reload .vimrc and :PlugInstall to install plugins.
"
" Plug options:
"
"| Option                  | Description                                      |
"| ----------------------- | ------------------------------------------------ |
"| `branch`/`tag`/`commit` | Branch/tag/commit of the repository to use       |
"| `rtp`                   | Subdirectory that contains Vim plugin            |
"| `dir`                   | Custom directory for the plugin                  |
"| `as`                    | Use different name for the plugin                |
"| `do`                    | Post-update hook (string or funcref)             |
"| `on`                    | On-demand loading: Commands or `<Plug>`-mappings |
"| `for`                   | On-demand loading: File types                    |
"| `frozen`                | Do not update unless explicitly specified        |
"
" More information: https://github.com/junegunn/vim-plug



" ========================================================================================== Vundle config

set nocompatible              " be iMproved, required
" filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" ================================ my plugin begin
Plugin 'preservim/nerdtree'
Plugin 'mhinz/vim-startify'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/taglist.vim'

" ================================ my plugin end

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ========================================================================================== startify config
" don't neet config, run vi can see interface

" ========================================================================================== nerdtree config
" 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1
" 将NERDTree的窗口设置在vim窗口的右侧（默认为左侧）
" let NERDTreeWinPos="right"
" 如果未指定文件，在vim启动时自动打开NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 如果我还要打开一个已保存的会话，例如vim -S session_file.vim，该怎么办？ 我不希望在这种情况下打开NERDTree。
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
" vim在打开目录时，自动打开NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" 映射特定的键或快捷方式以打开NERDTree ctrl+n
map <C-n> :NERDTreeToggle<CR>
" 如果唯一打开的窗口是NERDTree，即执行vim指令，只有nerdtree，可以直接按q关闭nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 在vimrc中使用这些变量可以更改箭头。以下是默认箭头符号
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" 可以通过将这些变量设置为空字符串来完全删除箭头，如下所示。 这不仅会删除箭头，还会删除箭头后的单个空格，从而将整棵树向左移动两个字符位置。
" let g:NERDTreeDirArrowExpandable = ''


" ========================================================================================== ctrlp config
" 更改默认映射和默认命令以调用CtrlP：
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" 调用时，除非指定了起始目录，否则CtrlP将根据此变量设置其本地工作目录：
let g:ctrlp_working_path_mode = 'ra'
" 'c'-当前文件的目录。
" 'r'-包含以下目录或文件之一的最接近的祖先：.git .hg .svn .bzr _darcs
" 'a'-类似于c，但是仅当CtrlP之外的当前工作目录不是当前文件目录的直接祖先时。
" 0或''（空字符串）-禁用此功能。

" 使用g：ctrlp_root_markers选项定义其他根标记。

" 使用Vim的wildignore和CtrlP自己的g：ctrlp_custom_ignore排除文件和目录：
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" 使用自定义文件列表命令：
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

" 检查：help ctrlp-options以获取其他选项。

" ========================================================================================== taglist config
" 默认打开Taglist 
let Tlist_Auto_Open=1 
"""""""""""""""""""""""""""""" 
" Tag list (ctags) 
"""""""""""""""""""""""""""""""" 
let Tlist_Ctags_Cmd = '/usr/bin/ctags' 
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
" let g:NERDTreeDirArrowCollapsible = ''
"
" https://zhuanlan.zhihu.com/p/85040099
