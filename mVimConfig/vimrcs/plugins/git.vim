" ── Git Plugins ────────────────────────────────────────

" ── fugitive（Git 集成）───────────────────────────────
" 无需额外配置，开箱即用。
" 常用命令：
"   :Gstatus    Git 状态
"   :Gdiff      Git diff
"   :Gblame     Git blame
"   :Gcommit    Git commit
"   :Gpush      Git push
"   :Gpull      Git pull

" ── gitgutter（行级 diff 标记）────────────────────────
" 默认显示git diff标记
let g:gitgutter_enabled=1
" 自定义 sign 符号（左侧 gutter 显示的 + - ~ 标记）
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '≡'

" ── git-blame（自动显示 blame 信息）───────────────────
" 光标停止移动约1秒后自动显示当前行的 git blame 信息
autocmd CursorHold * if IsInGitRepo() | call gitblame#echo() | endif

" ── vim-gitgutter blame 自动关闭 ──────────────────────
" 当光标离开 blame buffer 时自动关闭，避免窗口堆积
augroup vimcfg_git_blame_close
  autocmd!
  autocmd CursorHold * nested if &ft==# 'gitblame' | q | endif
augroup END
