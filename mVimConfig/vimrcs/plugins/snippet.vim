" ── Snippet & Clipboard Plugins ────────────────────────

" ── ultisnips（代码片段）──────────────────────────────
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-u>"
let g:UltiSnipsJumpBackwardTrigger="<c-i>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ── vim-snippets（片段库）─────────────────────────────
" 内置大量常用代码片段，与 ultisnips 配合使用。
" 无需额外配置，开箱即用。

" ── yankstack（剪贴板历史栈）──────────────────────────
" 剪贴板历史栈：粘贴时可以回溯之前复制/删除的内容
" <leader>yp 粘贴上一个复制内容（older），<leader>yn 粘贴下一个复制内容（newer）
" （注意：<C-p>已被CtrlP占用，<C-n>已被NERDTree占用，故使用leader前缀）
nmap <leader>yp <Plug>yankstack_substitute_older_paste
nmap <leader>yn <Plug>yankstack_substitute_newer_paste

" ── peekaboo（寄存器预览）─────────────────────────────
" 按 " 或 @ 时自动弹窗显示寄存器内容，无需手动操作
" 默认只在普通模式下触发
let g:peekaboo_window = 'vert bot 30new'  " 在底部垂直分栏显示，宽度30

" ── oscyank（远程剪贴板）──────────────────────────────
" 在正常模式下，<leader>c是一个将给定文本复制到剪贴板的运算符。
" 在正常模式下，<leader>cc将复制当前行。
" 在视觉模式下，<leader>c将复制当前选择。

" nmap <leader>c <Plug>OSCYankOperator
" nmap <leader>cc <leader>c_
" vmap <leader>c <Plug>OSCYankVisual
vmap <leader>y <Plug>OSCYankVisual

" ── accelerated-jk（j/k 加速滚动）─────────────────────
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
