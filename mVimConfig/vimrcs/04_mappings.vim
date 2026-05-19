" ── Key Mappings ───────────────────────────────────────

let mapleader=","  " 如果mapleader变量没有设置，则用默认的反斜杠代替

" ── 基础映射 ───────────────────────────────────────────
nmap <leader>w :w!<cr>  " 根据mapleader的值，这条指令的快捷键为 ,w
nmap <leader>f :find<cr>
" 按0跳到行首第一个非空白字符（比默认的跳到绝对行首更实用）
map 0 ^

" ── 窗口快捷方式 ──────────────────────────────────────
map <c-h> <c-w>h
map <c-l> <c-w>l
map <c-j> <c-w>j
map <c-k> <c-w>k
map <leader>q <c-w>q
" map <c-n> <c-w>n
" map <c-w> <c-w>w
" map <c-c> <c-w>c
" map <leader>q :q<cr>
" map <c-o> <c-w>o

" Alt+j/k 上下移动当前行（普通模式），可视模式下可上下移动选中的多行
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" 取消高亮快捷键
nnoremap <Leader>h :noh<CR>
" 进入命令行
nnoremap <Leader>sh :shell<CR>

" buffer 快捷方式  bNext  badd  ball  bdelete  behave  belowright  bfirst  blast
" bmodified  bnext  botright  bprevious
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bb :bp<CR>
nnoremap <Leader>bs :b#<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bc :bwipe<CR>

" ── 标签页快捷方式 ────────────────────────────────────
nnoremap <Leader>tN :tabnew<CR>
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprevious<CR>
nnoremap <Leader>tc :tabclose<CR>
" 关闭其他 tab
nnoremap <Leader>to :tabonly<CR>
" 新建tab并编辑文件 :tabedit {file}
nnoremap <Leader>te :tabedit

" <leader>tl 在当前tab和上次访问的tab之间快速切换（比数tab编号更方便）
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" ── 命令行增强 ────────────────────────────────────────
" Bash风格的命令行快捷键，在vim命令行（按:进入的模式）中使用：
"   Ctrl+A  跳到命令行行首
"   Ctrl+E  跳到命令行行尾
"   Ctrl+K  删除光标到行尾的内容
"   Ctrl+P  上一条命令历史（等同方向键上）
"   Ctrl+N  下一条命令历史（等同方向键下）
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" ── 全选/复制 ─────────────────────────────────────────
" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
" map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y

" ── 功能键 ─────────────────────────────────────────────
"去空行
nnoremap <F2> :g/^\s*$/d<CR>
"比较文件
nnoremap <C-F2> :vert diffsplit
"新建标签
map <M-F2> :tabnew<CR>
"列出当前目录文件
map <F3> :tabnew .<CR>
"打开树状文件目录
map <C-F3> \be

" ── 编译运行 ──────────────────────────────────────────
" F5: 编译运行当前文件 (调用 CompileRun)
" F6: 调试当前文件 (调用 CompileDbg)
" 函数定义见 06_functions.vim
nnoremap <F5> :call CompileRun()<CR>
nnoremap <F6> :call CompileDbg()<CR>

" ── Tab/Space 切换 ────────────────────────────────────
" F12: 切换 Tab 和 Space 模式 (调用 SwitchTab)
" 函数定义见 06_functions.vim
map <F12> :call SwitchTab()<CR>

" ── 快速插入日志 ──────────────────────────────────────
" <leader>ll: 插入 printf 日志并格式化 (调用 InsertLog)
" 函数定义见 06_functions.vim
nmap <leader>ll :call InsertLog()<CR>jVj==

" ── 主题切换 ──────────────────────────────────────────
" <leader>th: 切换 gruvbox/tokyonight 主题
" 已移至 02_theme.vim，此处保留映射引用
" nnoremap <Leader>th :ToggleTheme<CR>

" 注意：F2 键冲突说明
"   此处 F2 映射为 "去空行" (:g/^\s*$/d)
"   plugins.vim 中 SmartRename 也使用 F2
"   由于 plugins.vim 在此之后加载，后者会覆盖前者
"   如需使用 SmartRename，请以 plugins.vim 中的 F2 为准
