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
" Normal 背景色：跟随当前主题，不用 ctermbg=none（透明背景会导致光标移动残影）。
" 会受 vimtex 插件 syntax enable 的影响，因此需要在 ColorScheme 事件中重新设置。
function! s:set_normal_bg()
  if exists('g:colors_name') && g:colors_name ==# 'gruvbox'
    hi Normal ctermbg=235
  else
    hi Normal ctermbg=235
  endif
endfunction
augroup normal_bg_sync
  autocmd!
  autocmd ColorScheme * call s:set_normal_bg()
augroup END
call s:set_normal_bg()

autocmd InsertLeave * se nocul  " 用浅色高亮当前行，不知道为啥没用
autocmd InsertEnter * se cul    " 用浅色高亮当前行，不知道为啥没用
