" ── UI Plugins ─────────────────────────────────────────

" ── startify（启动界面）──────────────────────────────
" 显示最近打开的文件、书签、会话列表等，替代默认的空启动界面。
" 快捷键：
"   <leader>bb  打开/关闭 startify buffer
"   b           打开选中的文件
"   o           在新 tab 中打开
"   t           在新 tab 中打开并跳转
"   S/C-S       保存/删除会话
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

" ── NERDTree（文件树）──────────────────────────────────
" 文件系统浏览器，以树形结构展示目录和文件。
" 常用命令：
"   :NERDTree          打开 NERDTree
"   :NERDTreeClose     关闭 NERDTree
"   :NERDTreeToggle    切换 NERDTree
"   o                  打开文件/目录
"   t/T                新 tab 打开（跳转/不跳转）
"   i/gi               水平分屏打开（跳转/不跳转）
"   s/gs               垂直分屏打开（跳转/不跳转）
"   O                  递归打开目录
"   x/X                合拢目录
"   P/p                跳到根/父结点
"   C                  设当前目录为根
"   r/R                刷新当前/根目录
"   m                  文件系统菜单（ma 创建，md 删除）
"   I                  显示/隐藏隐藏文件
"   q                  关闭 NERDTree
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
" 隐藏无需关注的文件和目录，减少目录树噪音
"   每项为 Vim 正则，匹配文件名或路径末段；优先级高于 ShowHidden
"   修改后需重新打开 NERDTree 窗口生效（或按 r 刷新）
let NERDTreeIgnore = [
      \ '\.git$', '\.pyc$', '__pycache__', 'node_modules',
      \ '\.o$', '\.swp$', '\.DS_Store$',
      \ 'cscope\..*', 'GPATH', 'GRTAGS', 'GTAGS', 'tags$',
      \ '\.claude$', '\.omc$'
      \ ]
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
nnoremap <C-n> :NERDTreeToggle<CR>
" 如果唯一打开的窗口是NERDTree，即执行vim指令，只有nerdtree，可以直接按q关闭nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 在vimrc中使用这些变量可以更改箭头。以下是默认箭头符号
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" 可以通过将这些变量设置为空字符串来完全删除箭头，如下所示。 这不仅会删除箭头，还会
" 删除箭头后的单个空格，从而将整棵树向左移动两个字符位置。
" let g:NERDTreeDirArrowExpandable = ''
" 快速定位当前文件在目录树中的位置
nmap <silent> <Leader>v :NERDTreeFind<CR>

" ── airline（状态栏增强）──────────────────────────────
" 美化底部状态栏，显示模式、分支、编码、文件类型等信息。
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩

" Airline 这个是安装字体后 必须设置此项
let g:airline_powerline_fonts = 1
" airline 的 tabline 替代内置标签栏，显示更美观的标签页
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '  "separater
let g:airline#extensions#tabline#left_alt_sep = '|'  "separater
let g:airline#extensions#tabline#formatter = 'default'  "formater
" 不使用 powerline 字体时使用 ASCII 分隔符
" let g:airline_left_sep='>'
" let g:airline_right_sep='<'
" let g:airline_symbols.linenr = 'Ln'
" let g:airline_symbols.maxlinenr = ''
let g:airline_theme='bubblegum' "选择主题

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

" ── vim-devicons（文件图标）───────────────────────────
" 为 NERDTree、airline、ctrlp 等插件提供文件类型图标。
" 需要安装 Nerd Font 才能正常显示图标字形。
" 安装方法：运行 init.sh 选择 vim 会自动安装 FiraCode Nerd Font
" 或手动从 https://www.nerdfonts.com/font-downloads 下载
" 安装后在终端设置中将字体改为 "FiraCode Nerd Font Mono"
" 关系链：Nerd Font → vim-devicons → NERDTree/airline（被增强）
let g:WebDevIconsUnicodeGlyphDoubleWidth = 2
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_ctrlp = 1

" ── indentLine（缩进线）────────────────────────────────
" 显示垂直缩进线，帮助识别代码块层级。
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" 隐藏颜色
let g:indentLine_setColors = 1
let g:indentLine_color_term = 239
" indentLine 背景色：根据主题切换
function! s:set_indent_colors()
  if get(g:, 'colors_name', '') =~# 'gruvbox'
    let g:indentLine_bgcolor_gui = '#3c3836'
  else
    let g:indentLine_bgcolor_gui = '#24283b'
  endif
endfunction
augroup theme_indent_colors
  autocmd!
  autocmd ColorScheme * call s:set_indent_colors()
augroup END
call s:set_indent_colors()

" ── vim-illuminate（光标单词高亮）──────────────────────
" 高亮光标下相同单词，默认高亮范围有限，增大一些。
let g:Illuminate_delay = 100      " 延迟100ms后高亮（避免快速移动时闪烁）
let g:Illuminate_highlightUnderCursor = 1  " 也高亮光标所在的单词
" 自定义高亮颜色：根据主题切换
function! s:set_illuminate_colors()
  if get(g:, 'colors_name', '') =~# 'gruvbox'
    hi illuminatedWord cterm=underline ctermbg=59 guibg=#3d2a28 gui=underline
  else
    hi illuminatedWord cterm=underline ctermbg=23 guibg=#2d2f45 gui=underline
  endif
endfunction
augroup theme_illuminate_colors
  autocmd!
  autocmd ColorScheme * call s:set_illuminate_colors()
augroup END
call s:set_illuminate_colors()
" 跳转到下一个/上一个高亮单词
nmap <leader>in <Plug>(illuminateNext)
nmap <leader>ip <Plug>(illuminatePrev)

" ── vim-lastplace（光标位置恢复）──────────────────────
" 自动恢复上次编辑时光标所在位置。
" 无需额外配置，开箱即用。自动忽略以下场景：
"   git commit、git rebase 等临时 buffer
"   fugitive、nerdtree 等插件 buffer
"   startify 等非文件 buffer
