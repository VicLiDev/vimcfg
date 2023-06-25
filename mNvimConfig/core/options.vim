scriptencoding utf-8

" 在被分割的窗口间显示空白，便于阅读
" change fillchars for folding, vertical split, end of buffer, and message separator
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Time in milliseconds to wait for a mapped sequence to complete,
" see https://unix.stackexchange.com/q/36882/221410 for more info
set timeoutlen=500

set updatetime=500  " For CursorHold events

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
if !empty(provider#clipboard#Executable())
  set clipboard+=unnamedplus
endif

" 在使用vim编辑文件后，总是会有一个以.swp 结尾的文件自动生成，
" 关闭文件之后这个文件会自动消失，这个文件是当前编辑文件的备份文件，
" 不需要这个文件的话可以使用这条设置
" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" Ignore certain files and folders when globing
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase  " ignore file and dir name cases in cmd-completion

" Set up backup directory
let g:backupdir=expand(stdpath('data') . '/backup//')
let &backupdir=g:backupdir

" Skip backup for patterns in option wildignore
let &backupskip=&wildignore
set backup  " create backup for files
set backupcopy=yes  " copy the original file to backupdir and overwrite it

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

set number relativenumber  " Show line number and relative line number
set norelativenumber

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" File and script encoding settings for vim
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Break line at predefined characters
set linebreak
" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" List all matches and complete till longest common string
set wildmode=list:longest

" Minimum lines to keep above and below cursor when scrolling
set scrolloff=5

" Use mouse to select and resize windows, etc.
set mouse=nic  " Enable mouse in several mode
set mousemodel=popup  " Set the behaviour of mouse
set mousescroll=ver:1,hor:6

" Disable showing current mode on command line since statusline plugins can show it.
set noshowmode

set fileformats=unix,dos  " Fileformats to use for new files

" Ask for confirmation when handling unsaved or read-only files
set confirm

set visualbell noerrorbells  " Do not use visual and errorbells
set history=500  " The number of command and search history to keep

" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣

" Auto-write the file based on some condition
set autowrite

" Show hostname, full path of file and last-mod time on the window title. The
" meaning of the format str for strftime can be found in
" http://man7.org/linux/man-pages/man3/strftime.3.html. The function to get
" lastmod time is drawn from https://stackoverflow.com/q/8426736/6064933
set title
set titlestring=
set titlestring=%{utils#Get_titlestr()}

" Persistent undo even after you close a file and re-open it
set undofile

" Do not show "match xx of xx" and other messages during auto-completion
set shortmess+=c

" Do not show search match count on bottom right (seriously, I would strain my
" neck looking at it). Using plugins like vim-anzu or nvim-hlslens is a better
" choice, IMHO.
set shortmess+=S

" Disable showing intro message (:intro)
set shortmess+=I

" Completion behaviour
" set completeopt+=noinsert  " Auto select the first completion entry
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

set pumheight=10  " Maximum number of items to show in popup menu
set pumblend=10  " pseudo transparency for completion menu

set winblend=0  " pseudo transparency for floating window

" Insert mode key word completion setting
set complete+=kspell complete-=w complete-=b complete-=u complete-=t

set spelllang=en,cjk  " Spell languages
set spellsuggest+=9  " show 9 spell suggestions at most

" Align indent to next multiple value of shiftwidth. For its meaning,
" see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
set shiftround

set virtualedit=block  " Virtual edit is useful for visual block edit

" Correctly break multi-byte characters such as CJK,
" see https://stackoverflow.com/q/32669814/6064933
set formatoptions+=mM

" Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
set tildeop

set synmaxcol=250  " Text after this column number is not highlighted
set nostartofline

" External program to use for grep command
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" Enable true color support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
set termguicolors

" Set up cursor color and shape in various mode, ref:
" https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20

set signcolumn=yes:1

" Remove certain character from file name pattern matching
set isfname-==
set isfname-=,

" diff options
set diffopt=
set diffopt+=vertical  " show diff in vertical position
set diffopt+=filler  " show filler for deleted lines
set diffopt+=closeoff  " turn off diff when one file window is closed
set diffopt+=context:3  " context for diff
set diffopt+=internal,indent-heuristic,algorithm:histogram
set diffopt+=linematch:60

set nowrap  " do no wrap
set noruler
set ruler  " 显示标尺，标尺显示文件中的光标位置。
set colorcolumn=80 " 您可以使用：set colorcolumn（简称：set cc）选项在特定列显示标尺，该选项仅在Vim 7.3或更高版本中可用。
set cursorline " 突出显示当前行，在当前行下边画一条线
" set cursorcolumn " 突出显示当前列，在当前行下边画一条线


" colorscheme gruvbox  "设置配色方案
" color darkblue "设置背景主题，跟colorscheme好像是一样的
set background=dark "背景使用黑色


"C，C++ run
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %< -Wall -Wextra && ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< -Wall -Wextra && ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'python'
        :!python ./%
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++ debug
map <F6> :call CompileRunGdb()<CR>
func! CompileRunGdb()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -g -o %< -Wall -Wextra && gdb --command=debug.gdb ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -g -o %< -Wall -Wextra && gdb --command=debug.gdb ./%<"
    elseif &filetype == 'python'
        exec "!python -m pdb ./%"
    endif
endfunc
" project run
map <F7> :call PrjCompileRun()<CR>
func! PrjCompileRun()
    exec "w"
    exec "!cd `git rev-parse --show-toplevel` && if [ -e \"./prjBuild.sh\" ]; then bash ./prjBuild.sh; elif [ -e \"./.prjBuild.sh\" ]; then bash ./.prjBuild.sh; else echo \"file $PWD/prjBuild.sh no exit\"; echo \"file $PWD/.prjBuild.sh no exit\"; fi"
endfunc
" project debug
map <F8> :call PrjCompileRunDbg()<CR>
func! PrjCompileRunDbg()
    exec "w"
    exec "!cd `git rev-parse --show-toplevel` && if [ -e \"./prjDebug.sh\" ]; then bash ./prjDebug.sh; elif [ -e \"./.prjDebug.sh\" ]; then bash ./.prjDebug.sh; else echo \"file $PWD/prjDebug.sh no exit\"; echo \"file $PWD/.prjDebug.sh no exit\"; fi"
endfunc
