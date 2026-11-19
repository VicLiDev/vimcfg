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
" 光标停止移动约 2 秒后自动显示当前行的 git blame 信息。
" 用 timer 替代 CursorHold：CursorHold 由 vim-polyglot 的 updatetime=300
" 高频触发，每次同步执行两次 git 命令会阻塞 vim 处理输入，按键被终端
" 回显成屏幕噪音（vim/vim#14001）。timer 方案只在真实停顿 2 秒后触发一次，
" 且不改动 updatetime，taglist/devicons/gitgutter 等其余 CursorHold
" 功能保持原有刷新频率。
" 只在普通的、有文件名的 buffer 上显示 blame:
" - 无名 buffer(启动时没带文件、[No Name])会让 git blame "" 报
"   fatal: no such path '' in HEAD, 插件会显示成 [Unhandled error: ...],
"   并再叠一次 "Press ENTER"。F5 编译期间排队的定时器会在编译结束、
"   提示符处触发, 所以这种场景最容易看到它。
" - terminal/quickfix/help 等 buftype 非空的 buffer 也不适合走 blame
function! s:CanShowBlame()
  return empty(&buftype) && !empty(expand('%')) && IsInGitRepo()
endfunction

let s:blame_timer = -1
function! s:ScheduleBlame()
  if s:blame_timer >= 0
    call timer_stop(s:blame_timer)
  endif
  let s:blame_timer = timer_start(2000, { -> s:CanShowBlame() ? gitblame#echo() : 0 })
endfunction
autocmd CursorMoved,CursorMovedI * call s:ScheduleBlame()
autocmd VimEnter * call s:ScheduleBlame()

" ── vim-gitgutter blame 自动关闭 ──────────────────────
" 当光标离开 blame buffer 时自动关闭，避免窗口堆积
augroup vimcfg_git_blame_close
  autocmd!
  autocmd CursorHold * nested if &ft==# 'gitblame' | q | endif
augroup END
