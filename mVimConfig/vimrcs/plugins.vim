" ========================================================================================== startify config
" don't neet config, run vi can see interface
" 修复: startify 为每个条目分配单字符快捷键，q 可能被文件条目抢占导致无法退出
autocmd FileType startify nnoremap <buffer><silent><nowait> q :q<CR>

" ----- 自定义 Header -----
" 风格 1: Vim logo
" let g:startify_custom_header = [
"       \ '   ___                                    ',
"       \ '  / __\ _____  ____ _____      ____  ____ ',
"       \ ' / /   / _ \ \/ / / _ \ \ /\ / /  _ \/ __/',
"       \ '/ /___/  __/>  </  __/\ V  V / (_) \__ \ ',
"       \ '\____/\___/_/\_\ \___/ \_/\_/ \___/|___/ ',
"       \]
" 风格 2: 更大号的 Vim logo（取消上面注释，注释掉这个即可切换）
" let g:startify_custom_header = [
"       \ '8888888b.                    888     888 8888888  .d8888b.  8888888888',
"       \ '888   Y88b                   888     888   888   d88P  Y88b 888      ',
"       \ '888    888                   888     888   888   888    888 888      ',
"       \ '888   d88P  .d88b.  888  888 888     888   888   888         8888888 ',
"       \ '8888888P"  d88""88b 888  888 888     888   888   888         888     ',
"       \ '888 T88b   888  888 888  888 888     888   888   888    888 888     ',
"       \ '888  T88b  Y88..88P 888  888 888     888   888   Y88b  d88P 888     ',
"       \ '888   T88b  "Y88P"  888  888 8888888 888   8888888 "Y8888P"  888     ',
"       \]
" 风格 3: cowsay（需要系统安装 cowsay，取消下面注释，注释掉上面即可）
" let g:startify_custom_header = map(split(system('fortune | cowsay -W 50'), '\n'), '"   ". v:val')
" 风格 4: 随机 cowsay 动物（需要 cowsay）
" let s:cows = split(system('cowsay -l'), '\n')[1:]
" let g:startify_custom_header = map(split(system('fortune | cowsay -f '. s:cows[rand()%len(s:cows)] .' -W 50'), '\n'), '"   ". v:val')

" ----- 列表区域 -----
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']                          },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                         },
      \ { 'type': 'commands',  'header': ['   Commands']                          },
      \ { 'type': 'files',     'header': ['   Recent Files']                      },
      \ { 'type': 'dir',       'header': ['   Current Dir  '. getcwd()]           },
      \ ]

" ----- 最近文件数量 -----
let g:startify_files_number = 8

" ----- 书签 -----
let g:startify_bookmarks = [
      \ { 'c': '~/.vimrc' },
      \ { 'v': '~/Projects/vimcfg/mVimConfig' },
      \ { 'p': '~/Projects' },
      \ ]

" ----- Session 持久化（需要手动创建目录 mkdir -p ~/.vim/session）-----
" let g:startify_session_persistence = 1
" let g:startify_session_dir = '~/.vim/session'
" let g:startify_session_delete_buffers = 1

" ----- 自定义 footer -----
" 风格 1:
let g:startify_custom_footer = ['   "The only way to do great work is to love what you do."']
" 风格 2: 随机名言（需要系统安装 fortune）
" let g:startify_custom_footer = map(split(system('fortune -s -n 60'), '\n'), '"   ". v:val')
" 风格 3: 无 footer
" let g:startify_custom_footer = []

" ----- 更新统计信息（右下角）-----
let g:startify_update_oldfiles = 1
let g:startify_change_to_vcs_root = 1

" ========================================================================================== nerdtree config
" 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1
" 隐藏顶部的帮助信息（Press ? for help），界面更整洁
" let NERDTreeMinimalUI=1
" 隐藏 Bookmarks 面板的 'Bookmarks' 标题行
let NERDTreeMinimalMenu=1
" 窗口宽度（默认 31，适当加宽以避免路径被截断）
let NERDTreeWinSize=35
" 显示隐藏文件（以 . 开头的文件）
let NERDTreeShowHidden=1
" 高亮当前正在编辑的文件
let NERDTreeHighlightCursorline=1
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
" 可以通过将这些变量设置为空字符串来完全删除箭头，如下所示。 这不仅会删除箭头，还会
" 删除箭头后的单个空格，从而将整棵树向左移动两个字符位置。
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

" ========================================================================================== tagbar config
nmap <Leader>tb :TagbarToggle<CR>

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
"设置当前路径下的 tags。这里的分号是让vim首先在当前目录里寻找tags文件，如果没有找到
"tags文件，或者没有找到对应的目标，就到父目录中查找，一直向上递归。
set tags=tags;
" 因为tags文件中记录的路径总是相对于tags文件所在的路径，所以要使用该设置项来改变
" vim的当前目录。
set autochdir
"
"
" ========================================================================================== cscope config
" 添加当前路径下的cscope.out
cscope add cscope.out
" 打开cscope搜索快捷方式
map <Leader>cf :cs f


" ========================================================================================== gtag config
" 修复 autochdir 下 gtags 跳转路径错误（默认模式丢弃 --path-style=absolute 参数）
let g:Gtags_Emacs_Like_Mode = 1
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
" let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '▷'
" let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '◁'
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

" old vim-powerline symbols（旧配置，已被上方覆盖）
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
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
  \ 'hl':      ['fg', 'GruvboxYellow'],
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


" =============================================================================
" File: ~/.vimrc
" Description: Enhanced :Agit command for fuzzy searching with ag in Git repos
" Features:
"   1. Auto-detects Git root directory (falls back to current dir if not in Git)
"   2. Preserves original working directory after search
"   3. Supports fzf preview window and bang (!) mode
"   4. Robust error handling for non-Git directories and missing dependencies
" Usage:
"   :Agit pattern       - Search in Git root (or current dir)
"   :Agit! pattern      - Open results in preview window
" Dependencies:
"   - git (for repo detection)
"   - ag (The Silver Searcher)
"   - fzf + fzf.vim plugin
" =============================================================================
" Key Functionality Annotations:
" [1] Save original working directory to restore later
" [2] Check if current file is in Git repository (works in subdirs)
" [3] Display warning when not in Git repo (yellow text)
" [4] Safely get Git root dir (empty if not in repo)
" [5] Change to Git root dir only if valid
" [6] Invoke fzf's ag interface with search pattern
" [7] Configure fzf to show filename:line:column format
" [8] Enable preview window (shows code context)
" [9] Catch "unknown function" errors with helpful message
" [10] Always restore original directory after search
" =============================================================================
" 这里 | 用于将多个 Vim 语句连接成一行（因为 command! 要求命令体必须是单行）
" =============================================================================
command! -bang -nargs=* Agit
  \ let s:ag_saved_cwd = getcwd() |
  \ let s:is_git = system('git rev-parse --is-inside-work-tree 2>/dev/null') =~ 'true' |
  \ let s:ag_git_root = s:is_git ?
  \   trim(system('git rev-parse --show-toplevel 2>/dev/null')) : '' |
  \ if !empty(s:ag_git_root) |
  \   silent execute 'lcd' fnameescape(s:ag_git_root) |
  \ endif |
  \ try |
  \   call fzf#vim#ag(<q-args>,
  \     extend({'options': '--delimiter : --nth 4..'},
  \     fzf#vim#with_preview()),
  \     <bang>0) |
  \ catch /E117/ |
  \   echoerr 'fzf.vim not installed or ag not found!' |
  \ endtry |
  \ silent execute 'lcd' fnameescape(s:ag_saved_cwd)


" 工具在 vimrcs/fzf/fzf.vim 中都有写，根据需要将其中一些做映射
map <Leader>ff   :Files<CR>
map <Leader>fg   :GFiles<CR>
map <Leader>fb   :Buffers<CR>
map <Leader>ft   :Tags<CR>
map <Leader>fr   :Rg<CR>
map <Leader>fa   :Agit<CR>
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
" 光标停止移动约1秒后自动显示当前行的 git blame 信息
autocmd CursorHold * if IsInGitRepo() | call gitblame#echo() | endif

" ========================================================================================== gitgutter config
" 默认显示git diff标记
let g:gitgutter_enabled=1

" ========================================================================================== vim-mark
nmap <Leader>mc <Plug>MarkAllClear

" ========================================================================================== markdown-preview
nmap <Leader>md :MarkdownPreview<CR>

" ========================================================================================== vim-c-cpp-modern
" 增强 C/C++ 语法高亮
let g:cpp_function_highlight = 1      " 高亮函数名
let g:cpp_member_highlight = 1        " 高亮结构体/对象成员
let g:cpp_type_name_highlight = 1     " 高亮 struct/union/enum/class 名
let g:cpp_operator_highlight = 1      " 高亮运算符

" ========================================================================================== ctags 自定义类型高亮
" 从 tags 文件中提取自定义类型名(struct/union/enum/typedef/class)并高亮
" 需要先用 ctags -R 生成 tags 文件，打开 C/C++ 文件时自动加载
" 使用 :CtagsHighlight 手动刷新，:CtagsHighlightClear 清除高亮
" 实际触发点在 after/syntax/c.vim 和 after/syntax/cpp.vim（确保在所有语法文件之后执行）
" 注意：此方案是语法层面的着色，不依赖 LSP，与 clangd 互不冲突
" 设置 g:ctags_type_highlight=0 可关闭此功能
let g:ctags_type_highlight = get(g:, 'ctags_type_highlight', 1)
let s:ctags_type_cache = {}
let s:ctags_type_mtime = {}

function! s:ParseCtagsTypes(tags_file) abort
    if !filereadable(a:tags_file)
        return []
    endif
    " 缓存检查：tags 文件未修改时跳过解析
    let l:mtime = getftime(a:tags_file)
    if get(s:ctags_type_mtime, a:tags_file, -1) == l:mtime
        \ && has_key(s:ctags_type_cache, a:tags_file)
        return s:ctags_type_cache[a:tags_file]
    endif
    let l:types = []
    let l:type_kinds = {'s': 1, 'u': 1, 'g': 1, 't': 1, 'c': 1}
    " 仅提取 C/C++ 源文件中的类型
    let l:c_exts = '\.\(c\|h\|cpp\|cc\|hpp\|cxx\|cu\)$'
    for l:line in readfile(a:tags_file, '', 100000)
        if l:line =~# '^!'
            continue
        endif
        let l:fields = split(l:line, "\t", 1)
        if len(l:fields) < 4
            continue
        endif
        " fields[0]=tagname, fields[1]=file, fields[2]=pattern, fields[3]=kind
        if !has_key(l:type_kinds, l:fields[3])
            continue
        endif
        if l:fields[1] !~# l:c_exts
            continue
        endif
        let l:name = l:fields[0]
        if l:name !~# '^\w'
            continue
        endif
        call add(l:types, l:name)
    endfor
    let l:types = uniq(sort(l:types))
    let s:ctags_type_cache[a:tags_file] = l:types
    let s:ctags_type_mtime[a:tags_file] = l:mtime
    return l:types
endfunction

function! s:CtagsHighlight() abort
    " 每个 session 只加载一次，避免每次打开文件重复解析 tags
    if get(s:, 'ctags_loaded', 0)
        return
    endif
    silent! syntax clear cTagsType
    let l:all_types = []
    " 使用 tagfiles() 获取 Vim 已加载的 tags 文件路径（正确处理 ; 向上搜索）
    for l:tags_path in tagfiles()
        call extend(l:all_types, s:ParseCtagsTypes(l:tags_path))
    endfor
    if empty(l:all_types)
        return
    endif
    let l:all_types = uniq(sort(l:all_types))
    " syntax keyword 有长度限制，分批添加（每批约 8000 字符）
    let l:batch = []
    let l:batch_len = 0
    for l:t in l:all_types
        call add(l:batch, l:t)
        let l:batch_len += len(l:t) + 1
        if l:batch_len >= 8000
            execute 'syntax keyword cTagsType ' . join(l:batch)
            let l:batch = []
            let l:batch_len = 0
        endif
    endfor
    if !empty(l:batch)
        execute 'syntax keyword cTagsType ' . join(l:batch)
    endif
    hi! link cTagsType Type
    let s:ctags_loaded = 1
endfunction

command! CtagsHighlight let s:ctags_loaded = 0 | call <SID>CtagsHighlight()
command! CtagsHighlightClear silent! syntax clear cTagsType

" ========================================================================================== vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_emphasis_multiline = 0
hi clear markdownError

" 覆盖 vim-markdown 的语法高亮配色
"
" 原因：vim-markdown 使用自己的 mkd*/htmlH* 语法组（如 mkdCode、mkdHeading、htmlH1 等），
"       而非 Vim 标准的 markdown* 组（如 markdownCode、markdownH1 等）。
"       gruvbox 配色方案中定义的 markdown* 高亮链接不会被 vim-markdown 匹配，因此无效。
"       需要在 FileType autocmd 中用 hi! 强制覆盖 vim-markdown 的 hi default link 设置。
"       （hi default link 只在组无高亮定义时生效，hi! 则无条件覆盖）
augroup vim_markdown_colors
  autocmd!
  autocmd FileType markdown call s:apply_markdown_colors()
augroup END
function! s:apply_markdown_colors()
  " 标题内容: 暖到冷渐变 (橙->黄->绿->青->蓝->紫)，与 after/colors/gruvbox.vim 统一
  hi! htmlH1 cterm=bold ctermfg=208 guifg=#fe8019 gui=bold
  hi! htmlH2 cterm=bold ctermfg=214 guifg=#fabd2f gui=bold
  hi! htmlH3 cterm=bold ctermfg=142 guifg=#b8bb26 gui=bold
  hi! htmlH4 cterm=bold ctermfg=108 guifg=#8ec07c gui=bold
  hi! htmlH5 cterm=bold ctermfg=109 guifg=#83a598 gui=bold
  hi! htmlH6 cterm=bold ctermfg=175 guifg=#d3869b gui=bold
  " 标题 # 分隔符: 柔和灰，与标题内容区分
  hi! mkdHeading ctermfg=246 guifg=#a89984
  " 行内代码: 柔和前景色
  hi! mkdCode ctermfg=246 guifg=#a89984
  hi! mkdCodeDelimiter ctermfg=243 guifg=#7c6f64
  hi! mkdCodeStart ctermfg=246 guifg=#a89984
  hi! mkdCodeEnd ctermfg=246 guifg=#a89984
  " 引用块
  hi! mkdBlockquote cterm=italic ctermfg=246 guifg=#a89984 gui=italic
  " 列表标记
  hi! mkdListItem ctermfg=208 guifg=#fe8019
  " 分隔线
  hi! mkdRule ctermfg=243 guifg=#7c6f64
  " 链接
  hi! mkdURL ctermfg=109 guifg=#83a598
  hi! mkdInlineURL cterm=underline ctermfg=109 guifg=#83a598 gui=underline
  hi! mkdLink cterm=underline ctermfg=109 guifg=#83a598 gui=underline
  " 脚注
  hi! mkdFootnote ctermfg=246 guifg=#a89984
  " 分隔符
  hi! mkdDelimiter ctermfg=243 guifg=#7c6f64
endfunction

" ========================================================================================== uml
" docker run -d -p 8888:8080 plantuml/plantuml-server:jetty
let g:preview_uml_url='http://localhost:8888'
map <Leader>uml  :PreviewUML<CR>

" ========================================================================================== indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" 隐藏颜色
let g:indentLine_setColors = 1
let g:indentLine_color_term = 239
" indentLine 背景色使用 gruvbox dark1 色调，与主题和谐
let g:indentLine_bgcolor_gui = '#3c3836'


" ========================================================================================== ultisnips
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-u>"
let g:UltiSnipsJumpBackwardTrigger="<c-i>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" ========================================================================================== vimtex
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","


" ========================================================================================== vim-oscyank
" 在正常模式下，<leader>c是一个将给定文本复制到剪贴板的运算符。
" 在正常模式下，<leader>cc将复制当前行。
" 在视觉模式下，<leader>c将复制当前选择。

" nmap <leader>c <Plug>OSCYankOperator
" nmap <leader>cc <leader>c_
" vmap <leader>c <Plug>OSCYankVisual
vmap <leader>y <Plug>OSCYankVisual

" ========================================================================================== rhysd/accelerated-jk
" 仅在插件正常加载时映射 j/k，避免加载失败导致 j/k 失效
if mapcheck('<Plug>(accelerated_jk_gj)', 'n') !=# ''
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif

" 高级配置选项
" [初始延迟ms, 后续间隔ms]
"   按住多少秒后开始加速
"   后续每次提速的时间间隔
let g:accelerated_jk_acceleration_table = [2, 2]
" 设置最大提速上限，5 表示最快时每次按键相当于移动 5 次（即 5 倍速）
let g:accelerated_jk_acceleration_limit = 10
" 禁用h/l加速（默认只加速j/k）
let g:accelerated_jk_enable_h = 0
let g:accelerated_jk_enable_l = 0

" ========================================================================================== yankstack config
" 剪贴板历史栈：粘贴时可以回溯之前复制/删除的内容
" <leader>yp 粘贴上一个复制内容（older），<leader>yn 粘贴下一个复制内容（newer）
" （注意：<C-p>已被CtrlP占用，<C-n>已被NERDTree占用，故使用leader前缀）
nmap <leader>yp <Plug>yankstack_substitute_older_paste
nmap <leader>yn <Plug>yankstack_substitute_newer_paste

" ========================================================================================== ale config
" 异步语法检查（linting），支持多种语言，比YCM的lint更轻量
" 配置各语言的lint工具（可根据实际安装的工具增减）
let g:ale_linters = {
\   'javascript': ['jshint'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck']
\}
" clangd 配置（C/C++ LSP，提供语义诊断和代码智能，仅在 clangd 已安装时启用）
" 注意: clangd 在 Vim 中不提供语义着色(semanticTokens)，自定义类型着色由 ctags 方案负责
" 安装: sudo apt install clangd 或通过 LLVM 安装
" 建议: 生成 compile_commands.json (CMake: -DCMAKE_EXPORT_COMPILE_COMMANDS=ON, 或 bear -- make)
if executable('clangd')
    let g:ale_linters['c'] = ['clangd']
    let g:ale_linters['cpp'] = ['clangd']
    let g:ale_c_clangd_options = '--header-insertion=never --clang-tidy'
    let g:ale_cpp_clangd_options = '--header-insertion=never --clang-tidy'
    " clangd 跳转到定义
    nmap <silent> <leader>gd :ALEGoToDefinition<CR>
    " clangd 查看类型信息/文档
    nmap <silent> <leader>k :ALEHover<CR>
    " clangd 查找引用（注意: <leader>gr 已被 gtags 占用，此处用 <leader>lr）
    nmap <silent> <leader>lr :ALEFindReferences<CR>
endif
" <leader>a 跳转到下一个语法错误/警告
nmap <silent> <leader>a <Plug>(ale_next_wrap)
" 禁用高亮标记（避免与colorscheme冲突导致显示异常）
let g:ale_set_highlights = 0
" 仅在保存文件时进行lint检查，不在输入时频繁检查（减少干扰）
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" ========================================================================================== vim-surround config
" 无需额外配置，开箱即用
" 核心操作：
"   cs"'  — 替换：把 "hello" 变成 'hello'
"   ds"   — 删除：把 "hello" 变成 hello
"   ysiw) — 添加：给光标所在单词加括号 (word)
"   yss)  — 添加：给整行加括号
"   ySSt{ — 添加：给整行加花括号并换行
"   cst"  — 替换标签：把 <b>word</b> 变成 "word"

" ========================================================================================== auto-pairs config
" 自动补全括号和引号，选中状态下输入括号会包裹选中文本
" 按 Backspace 同时删除一对括号，按 Ctrl-h 跳转到下一个配对位置
let g:AutoPairsFlyMode = 0       " 禁用飞模式（输入右括号直接跳过，不飞到末尾）
let g:AutoPairsShortcutBackInsert = '<M-b>'  " Alt+b 在跳过和插入之间切换

" ========================================================================================== undotree config
" 快捷键
nnoremap <Leader>u :UndotreeToggle<CR>
" 设置 undotree 窗口位置和大小
let g:undotree_WindowLayout = 2   " 2=左右分栏（左侧undo树，右侧文件内容）
let g:undotree_SplitWidth = 40    " undo树窗口宽度
let g:undotree_DiffpanelHeight = 10  " diff面板高度
" 如果已设置 undofile（commoncfg.vim 中已配置），undotree 会自动使用持久化撤销历史
" let g:undotree_SetFocusWhenToggle = 1  " 打开时自动聚焦到 undotree 窗口

" ========================================================================================== vim-illuminate config
" 高亮光标下相同单词，默认高亮范围有限，增大一些
let g:Illuminate_delay = 100      " 延迟100ms后高亮（避免快速移动时闪烁）
let g:Illuminate_highlightUnderCursor = 1  " 也高亮光标所在的单词
" 自定义高亮颜色：暗橙底色 + 青蓝色调 + 下划线，适配 gruvbox 暗色主题
" 直接设置（不能用 ColorScheme autocmd，因为 colorscheme 在本文件之前就已加载）
hi illuminatedWord cterm=underline ctermbg=59 guibg=#3d2a28 gui=underline
" 跳转到下一个/上一个高亮单词
nmap <leader>in <Plug>(illuminateNext)
nmap <leader>ip <Plug>(illuminatePrev)

" ========================================================================================== vim-lastplace config
" 无需额外配置，开箱即用
" 自动忽略以下场景的光标位置恢复：
"   git commit、git rebase 等临时 buffer
"   fugitive、nerdtree 等插件 buffer
"   startify 等非文件 buffer

" ========================================================================================== Colorizer config
" 手动开启/关闭颜色预览
nnoremap <Leader>cc :ColorHighlight<CR>
nnoremap <Leader>cC :ColorHighlightClear<CR>
" 在特定文件类型中自动启用
autocmd FileType css,scss,html,xml,vim,conf,json :ColorHighlight

" ========================================================================================== vim-peekaboo config
" 按 " 或 @ 时自动弹窗显示寄存器内容，无需手动操作
" 默认只在普通模式下触发
let g:peekaboo_window = 'vert bot 30new'  " 在底部垂直分栏显示，宽度30

" ========================================================================================== F2/F3 跨文件重命名
" F2: 搜索光标下的词 → 选择搜索范围（项目/当前文件）→ quickfix 预览
" F3: 逐条确认替换（y/n/a/q/l），依赖 Ferret 插件

function! SmartRename()
  let l:word = expand('<cword>')
  if l:word ==# ''
    return
  endif
  let l:new = input('Rename "' . l:word . '" to: ')
  if l:new ==# '' || l:new ==# l:word
    return
  endif
  call setreg('z', l:word)
  call setreg('y', l:new)
  " 选择搜索范围
  let l:git_root = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '\n', '', 'g')
  if l:git_root =~# '\S'
    let l:scope = input('Search scope [P]roject / [C]urrent file (default C): ')
    if l:scope =~? '^p'
      execute 'Ack \b' . l:word . '\b ' . l:git_root
    else
      execute 'vimgrep /\<' . escape(l:word, '/\.*$^~[]') . '\>/j %'
    endif
  else
    execute 'vimgrep /\<' . escape(l:word, '/\.*$^~[]') . '\>/j %'
  endif
  if empty(getqflist())
    echo 'No matches found'
    return
  endif
  copen
  echo 'Press F3 to replace, :cclose to cancel'
endfunction

function! DoRename()
  let l:old = getreg('z')
  let l:new = getreg('y')
  if l:old ==# '' || l:new ==# ''
    echo 'Use F2 first'
    return
  endif
  cclose
  " 切换到非 NERDTree 的文件编辑窗口
  for i in range(1, winnr('$'))
    execute i . 'wincmd w'
    if &ft !=# 'nerdtree' && &ft !=# 'qf'
      break
    endif
  endfor
  let l:pat = '\<' . escape(l:old, '/\.*$^~[]') . '\>'
  let l:rep = escape(l:new, '/\.*$^~[]&')
  call feedkeys(':cfdo %s/' . l:pat . '/' . l:rep . '/gc | update' . "\<CR>", 't')
endfunction

nnoremap <F2> :call SmartRename()<CR>
nnoremap <F3> :call DoRename()<CR>

