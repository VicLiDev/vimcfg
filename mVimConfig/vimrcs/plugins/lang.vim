" ── Language Plugins ───────────────────────────────────

" ── vimtex（LaTeX 编辑）────────────────────────────────
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


" ── vim-markdown（Markdown 增强）───────────────────────
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
  autocmd ColorScheme * if &ft ==# 'markdown' | call s:apply_markdown_colors() | endif
augroup END
function! s:apply_markdown_colors()
  if get(g:, 'colors_name', '') =~# 'gruvbox'
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
  else
    " 标题内容: 暖到冷渐变，与 after/colors/tokyonight.vim 统一
    hi! htmlH1 cterm=bold ctermfg=215 guifg=#FF9E64 gui=bold
    hi! htmlH2 cterm=bold ctermfg=179 guifg=#E0AF68 gui=bold
    hi! htmlH3 cterm=bold ctermfg=107 guifg=#9ECE6A gui=bold
    hi! htmlH4 cterm=bold ctermfg=117 guifg=#7DCFFF gui=bold
    hi! htmlH5 cterm=bold ctermfg=110 guifg=#7AA2F7 gui=bold
    hi! htmlH6 cterm=bold ctermfg=180 guifg=#BB9AF7 gui=bold
    " 标题 # 分隔符
    hi! mkdHeading ctermfg=247 guifg=#7982a9
    " 行内代码
    hi! mkdCode ctermfg=247 guifg=#7982a9
    hi! mkdCodeDelimiter ctermfg=240 guifg=#565f89
    hi! mkdCodeStart ctermfg=247 guifg=#7982a9
    hi! mkdCodeEnd ctermfg=247 guifg=#7982a9
    " 引用块
    hi! mkdBlockquote cterm=italic ctermfg=247 guifg=#7982a9 gui=italic
    " 列表标记
    hi! mkdListItem ctermfg=215 guifg=#FF9E64
    " 分隔线
    hi! mkdRule ctermfg=240 guifg=#565f89
    " 链接
    hi! mkdURL ctermfg=110 guifg=#7AA2F7
    hi! mkdInlineURL cterm=underline ctermfg=110 guifg=#7AA2F7 gui=underline
    hi! mkdLink cterm=underline ctermfg=110 guifg=#7AA2F7 gui=underline
    " 脚注
    hi! mkdFootnote ctermfg=247 guifg=#7982a9
    " 分隔符
    hi! mkdDelimiter ctermfg=240 guifg=#565f89
  endif
endfunction

" ── markdown-preview（Markdown 预览）───────────────────
nmap <Leader>md :MarkdownPreview<CR>

" ── plantuml（UML 图预览）─────────────────────────────
" docker run -d -p 8888:8080 plantuml/plantuml-server:jetty
let g:preview_uml_url='http://localhost:8888'
map <Leader>uml  :PreviewUML<CR>

" ── polyglot（多语言语法）────────────────────────────
" 提供 150+ 种语言的语法高亮支持。
" 无需额外配置，开箱即用。
