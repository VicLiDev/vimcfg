" ── Theme & Colorscheme ───────────────────────────────

" ── 主题切换 ──────────────────────────────────────────
command! ToggleTheme call s:toggle_theme()
function! s:toggle_theme()
  if exists('g:colors_name') && g:colors_name ==# 'gruvbox'
    colorscheme tokyonight
  else
    colorscheme gruvbox
  endif
endfunction
nnoremap <Leader>th :ToggleTheme<CR>

" ── 状态行 ─────────────────────────────────────────────
" (已在 01_basic.vim 中设置 statusline 基础值，此处仅作备注)
" set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\\ [TYPE=%Y]\\ [POS=%l,%v][%p%%]\\ %{strftime(\"%d/%m/%y\\ -\\ %H:%M\")}

" ── 高亮组 ─────────────────────────────────────────────
" hi Normal: 指的是 Vim 的 Normal 高亮组，这通常是用于在普通模式（不是插入、可视
" 或其他特殊模式）下显示的文本。
" ctermfg=252: 设置终端前景色（文本颜色）为颜色代码 252。在大多数 256 色终端中，
" 颜色代码 252 通常表示一个非常浅的灰色或白色。
" ctermbg=none: 设置终端背景色为"无"或透明。这意味着文本的背景将使用终端的默认
" 背景色。
" 会受 vimtex 插件 syntax enable 的影响，因此这里不生效
" hi Normal ctermfg=252 ctermbg=none
hi Normal ctermbg=none

autocmd InsertLeave * se nocul  " 用浅色高亮当前行，不知道为啥没用
autocmd InsertEnter * se cul    " 用浅色高亮当前行，不知道为啥没用
