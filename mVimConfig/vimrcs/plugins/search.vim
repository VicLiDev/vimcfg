" ── Search & Navigation Plugins ─────────────────────────

" ── CtrlP（文件搜索）──────────────────────────────────
" 更改默认映射和默认命令以调用CtrlP：
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" 调用时，除非指定了起始目录，否则CtrlP将根据此变量设置其本地工作目录：
let g:ctrlp_working_path_mode = 'ra'
" 'c'-当前文件的目录。
" 'r'-包含以下目录或文件之一的最接近的祖先：.git .hg .svn .bzr _darcs
" 'a'-类似于c，但是仅当CtrlP之外的当前工作目录不是当前文件目录的直接祖先时。
" 0或''（空字符串）-禁用此功能。

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

" ── taglist（ctags 标签列表）─────────────────────────
" 默认打开Taglist
let Tlist_Auto_Open=0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag list (ctags)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
map <Leader>tt :Tlist<CR>

" https://zhuanlan.zhihu.com/p/85040099

" ── tagbar（标签栏增强）──────────────────────────────
nmap <Leader>tb :TagbarToggle<CR>
map <F8> :TagbarToggle<CR>

" ── ctags（标签生成）──────────────────────────────────
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

" ── ctags 自定义类型高亮 ─────────────────────────────
" 从 tags 文件中提取自定义类型名(struct/union/enum/typedef/class)并高亮
" 核心逻辑在 autoload/ctags_highlight.vim
" 需要先用 ctags -R 生成 tags 文件，打开 C/C++ 文件时自动加载
" 使用 :CtagsHighlight 手动刷新，:CtagsHighlightClear 清除高亮
" 实际触发点在 after/syntax/c.vim 和 after/syntax/cpp.vim（确保在所有语法文件之后执行）
" 注意：此方案是语法层面的着色，不依赖 LSP，与 clangd 互不冲突
" 设置 g:ctags_type_highlight=0 可关闭此功能
let g:ctags_type_highlight = get(g:, 'ctags_type_highlight', 1)

command! CtagsHighlight call ctags_highlight#refresh()
command! CtagsHighlightClear call ctags_highlight#clear()

" ── cscope（代码浏览）─────────────────────────────────
" 添加当前路径下的cscope.out
cscope add cscope.out
" 打开cscope搜索快捷方式
map <Leader>cf :cs f


" ── gtags（GNU GLOBAL 集成）───────────────────────────
" 修复 autochdir 下 gtags 跳转路径错误（默认模式丢弃 --path-style=absolute 参数）
let g:Gtags_Emacs_Like_Mode = 1
source ~/.vim/vimrcs/plugins/gtags.vim

" ── fzf（模糊搜索）────────────────────────────────────

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

" Preview window: right 50% width, hidden by default (toggle with Ctrl-/)
let g:fzf_preview_window = ["right:50%", "ctrl-/"]

" ── 备用布局方案（已禁用，按需取消注释切换）─────────
" 相对当前窗口居中
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
"
" 锚定在当前窗口底部
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
"
" 下方分窗 (非悬浮窗)
" let g:fzf_layout = { 'down': '40%' }
"
" Vim 命令窗口模式
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }


" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
function! s:set_fzf_colors()
  let l:hl_group = get(g:, 'colors_name', '') =~# 'gruvbox' ? 'GruvboxYellow' : 'Number'
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', l:hl_group],
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
endfunction
augroup theme_fzf_colors
  autocmd!
  autocmd ColorScheme * call s:set_fzf_colors()
augroup END
call s:set_fzf_colors()

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


" ──────────────────────────────────────────────────────────────────
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
" ──────────────────────────────────────────────────────────────────
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
" ──────────────────────────────────────────────────────────────────
" 这里 | 用于将多个 Vim 语句连接成一行（因为 command! 要求命令体必须是单行）
" ──────────────────────────────────────────────────────────────────
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


" ── easymotion（快速跳转）─────────────────────────────
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
