" ── Code Intelligence Plugins ──────────────────────────

" ── YCM（YouCompleteMe）────────────────────────────────
" 语义补全引擎，支持 C/C++/Python/JavaScript 等语言。
" 无需额外配置，开箱即用。
" 安装: cd ~/.vim/bundle/YouCompleteMe && python3 install.py --clangd-completer

" ── ALE（异步语法检查）────────────────────────────────
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

" ── vim-surround（括号包裹）──────────────────────────
" 无需额外配置，开箱即用
" 核心操作：
"   cs"'  — 替换：把 "hello" 变成 'hello'
"   ds"   — 删除：把 "hello" 变成 hello
"   ysiw) — 添加：给光标所在单词加括号 (word)
"   yss)  — 添加：给整行加括号
"   ySSt{ — 添加：给整行加花括号并换行
"   cst"  — 替换标签：把 <b>word</b> 变成 "word"

" ── auto-pairs（自动配对）────────────────────────────
" 自动补全括号和引号，选中状态下输入括号会包裹选中文本
" 按 Backspace 同时删除一对括号，按 Ctrl-h 跳转到下一个配对位置
let g:AutoPairsFlyMode = 0       " 禁用飞模式（输入右括号直接跳过，不飞到末尾）
let g:AutoPairsShortcutBackInsert = '<M-b>'  " Alt+b 在跳过和插入之间切换

" ── undotree（撤销树）────────────────────────────────
" 快捷键
nnoremap <Leader>u :UndotreeToggle<CR>
" 设置 undotree 窗口位置和大小
let g:undotree_WindowLayout = 2   " 2=左右分栏（左侧undo树，右侧文件内容）
let g:undotree_SplitWidth = 40    " undo树窗口宽度
let g:undotree_DiffpanelHeight = 10  " diff面板高度
" 如果已设置 undofile（commoncfg.vim 中已配置），undotree 会自动使用持久化撤销历史
" let g:undotree_SetFocusWhenToggle = 1  " 打开时自动聚焦到 undotree 窗口

" ── colorizer（颜色预览）──────────────────────────────
" 手动开启/关闭颜色预览
nnoremap <Leader>cc :ColorHighlight<CR>
nnoremap <Leader>cC :ColorHighlightClear<CR>
" 在特定文件类型中自动启用
autocmd FileType css,scss,html,xml,vim,conf,json :ColorHighlight

" ── vim-c-cpp-modern（增强 C/C++ 语法高亮）───────────
" 增强 C/C++ 语法高亮
let g:cpp_function_highlight = 1      " 高亮函数名
let g:cpp_member_highlight = 1        " 高亮结构体/对象成员
let g:cpp_type_name_highlight = 1     " 高亮 struct/union/enum/class 名
let g:cpp_operator_highlight = 1      " 高亮运算符

" ── F2/F3 跨文件重命名 ────────────────────────────────
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
      let g:smartrename_mode = 'project'
    else
      execute 'vimgrep /\<' . escape(l:word, '/\.*$^~[]') . '\>/j %'
      let g:smartrename_mode = 'local'
    endif
  else
    execute 'vimgrep /\<' . escape(l:word, '/\.*$^~[]') . '\>/j %'
    let g:smartrename_mode = 'local'
  endif
  if empty(getqflist())
    echo 'No matches found'
    return
  endif
  cclose
  botright copen
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

  if get(g:, 'smartrename_mode', '') ==# 'project'
    " 项目范围：手动遍历 quickfix 列表，逐文件替换 + 询问继续
    let l:files = {}
    for l:item in getqflist()
      let l:files[l:item.bufnr] = 1
    endfor
    let l:files_total = len(l:files)
    let l:files_done = 0
    for l:bufnr in keys(l:files)
      let l:files_done += 1
      let l:bname = bufname(str2nr(l:bufnr))
      silent execute 'buffer' str2nr(l:bufnr)
      try
        execute '%s/' . l:pat . '/' . l:rep . '/gce'
        update
      catch
        " 用户按 q 退出 :s 命令或无匹配
      endtry
      if l:files_done < l:files_total
        let l:ans = input('Continue to next file? [Y/n/q]: ')
        if l:ans =~? '^q'
          break
        elseif l:ans =~? '^n'
          continue
        endif
      else
        echo 'All files processed.'
      endif
    endfor
  else
    " 当前文件范围：原有 cfdo 逻辑不变
    call feedkeys(':cfdo %s/' . l:pat . '/' . l:rep . '/gc | update' . "\<CR>", 't')
  endif
endfunction

nnoremap <F2> :call SmartRename()<CR>
nnoremap <F3> :call DoRename()<CR>
