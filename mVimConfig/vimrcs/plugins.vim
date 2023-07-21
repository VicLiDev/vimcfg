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
Plugin 'zivyangll/git-blame.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
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
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'neoclide/coc.nvim'
Plugin 'junegunn/fzf'
"Plugin 'junegunn/fzf.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'skanehira/preview-uml.vim'
Plugin 'Yggdroot/indentLine'

if has('win32') || has('linux')
    Plugin 'https://github.com/autozimu/LanguageClient-neovim'
elseif has('mac')
endif

" color
Plugin 'morhetz/gruvbox'

" markdown
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'aklt/plantuml-syntax'
Plugin 'tyru/open-browser.vim.git'
Plugin 'weirongxu/plantuml-previewer.vim.git'
Plugin 'scrooloose/vim-slumlord'

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
" 快速定位当前文件在目录树中的位置
nmap <leader>v :NERDTreeFind<CR>


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

let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" 设置足够的显示高度，避免无法滚动看到所有文件
let g:ctrlp_max_height=1000

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
" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

" 检查：help ctrlp-options以获取其他选项。
"
"
" ------------------------------- ctrlp-funky config
" 默认 leader 为“\”
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" ========================================================================================== taglist config
" 默认打开Taglist 
let Tlist_Auto_Open=0
"""""""""""""""""""""""""""""" 
" Tag list (ctags) 
"""""""""""""""""""""""""""""""" 
"let Tlist_Ctags_Cmd = '/usr/bin/ctags' 
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
map <Leader>tt :Tlist<CR> 
"
" https://zhuanlan.zhihu.com/p/85040099

" ========================================================================================== ctags config
let Tlist_Sort_Type = "name"    " 按照名称排序  
"let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
autocmd FileType java set tags+=D:\tools\java\tags  
"autocmd FileType h,cpp,cc,c set tags+=D:\tools\cpp\tags  
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的
set tags=tags;  "设置当前路径下的 tags。这里的分号是让vim首先在当前目录里寻找tags文件，如果没有找到tags文件，或者没有找到对应的目标，就到父目录中查找，一直向上递归。
set autochdir  "因为tags文件中记录的路径总是相对于tags文件所在的路径，所以要使用该设置项来改变vim的当前目录。
"
"
" ========================================================================================== cscope config
" 添加当前路径下的cscope.out
cscope add cscope.out
" 打开cscope搜索快捷方式
map <Leader>cf :cs f 


" ========================================================================================== gtag config
source ~/.vim/vimrcs/gtags.vim

" ========================================================================================== airline config
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩

let g:airline#extensions#tabline#enabled = 1   " 是否打开tabline
let g:airline#extensions#tabline#left_sep = ' '  "separater
let g:airline#extensions#tabline#left_alt_sep = '|'  "separater
let g:airline#extensions#tabline#formatter = 'default'  "formater
set laststatus=2  "永远显示状态栏
" let g:airline_theme='bubblegum' "选择主题
let g:airline#extensions#tabline#enabled=1    "Smarter tab line: 显示窗口tab和buffer

" Airline 这个是安装字体后 必须设置此项
"let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" 可以在vim中执行 :help airline 获得相关符号
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
"let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = ' ␊:'
"let g:airline_symbols.linenr = ' ␤:'
"let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'

" ========================================================================================== fzf config

" demo from fzf/README-VIM.md
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - Popup window (center of the current window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

" - Popup window (anchored to the bottom of the current window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" lhj add config
" bin/ from https://github.com/junegunn/fzf.vim -->  fzf.vim/bin
" vim.vim from https://github.com/junegunn/fzf.vim -->  fzf.vim/autoload/fzf/vim.vim
source ~/.vim/vimrcs/fzf/vim.vim
" fzf.vim from https://github.com/junegunn/fzf.vim -->  fzf.vim/plugin/fzf.vim
source ~/.vim/vimrcs/fzf/fzf.vim

" 工具在 vimrcs/fzf/fzf.vim 中都有写，根据需要将其中一些做映射
map <Leader>ff   :Files<CR>
map <Leader>fg   :GFiles<CR>
map <Leader>fb   :Buffers<CR>
map <Leader>ft   :Tags<CR>
map <Leader>fr   :Rg<CR>
map <Leader>fa   :Ag<CR>
map <Leader>fc   :Commits<CR>
map <Leader>fbc  :BCommits<CR>


" ========================================================================================== easymotion config
nmap ss <Plug>(easymotion-s2)
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)1
"


" ========================================================================================== git blame config
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>


" ========================================================================================== markdown
let g:vim_markdown_math = 1

" ========================================================================================== uml
" docker run -d -p 8888:8080 plantuml/plantuml-server:jetty
let g:preview_uml_url='http://localhost:8888'
map <Leader>uml  :PreviewUML<CR>

" ========================================================================================== indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" 隐藏颜色
let g:indentLine_setColors = 1
let g:indentLine_color_term = 239
let g:indentLine_bgcolor_gui = '#FF5F00'
