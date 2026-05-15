" Theme 自定义覆盖 — 加载器
" after/plugin/ 由 Vim 在所有插件加载完成后自动 source
" 覆盖定义存放在 after/colors/{theme}.vim

augroup theme_custom
  autocmd!
  autocmd ColorScheme gruvbox runtime! after/colors/gruvbox.vim
  autocmd ColorScheme tokyonight runtime! after/colors/tokyonight.vim
augroup END

" 启动时应用（colorscheme 在 commoncfg.vim 中先于本文件执行）
if exists('g:colors_name')
  if g:colors_name ==# 'gruvbox'
    runtime! after/colors/gruvbox.vim
  elseif g:colors_name ==# 'tokyonight'
    runtime! after/colors/tokyonight.vim
  endif
endif
