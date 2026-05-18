" ── Autocommands ────────────────────────────────────────

augroup vimcfg_filetype
    autocmd!
    " 高亮显示普通txt文件（需要txt.vim脚本）
    if has('win32') || has('linux')
        autocmd BufRead,BufNewFile *  setfiletype txt
    endif
augroup END

augroup vimcfg_cursorline
    autocmd!
    autocmd InsertLeave * se nocul  " 离开插入模式时高亮当前行
    autocmd InsertEnter * se cul    " 进入插入模式时取消高亮
augroup END

augroup vimcfg_cleanup
    autocmd!
    " 保存文件时自动清理行尾空格
    autocmd BufWritePre *.c,*.cpp,*.h,*.hpp,*.sh,*.py,*.java,*.vim :call CleanExtraSpaces()
    " C/C++ 文件设置 make 映射
    autocmd FileType c,cpp nnoremap <buffer> <F9> :w <bar> make %:r <CR>
augroup END

augroup vimcfg_tabtrack
    autocmd!
    " 记录最后访问的 tab，用于 <leader>tl 快速切换
    autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

augroup vimcfg_template
    autocmd!
    " 新建 .c/.h/.cpp/.hpp/.sh/.py/.java 文件时自动插入文件头
    autocmd BufNewFile *.cpp,*.hpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()"
    " 新建文件后自动定位到文件末尾
    autocmd BufNewFile * normal G
augroup END

augroup vimcfg_gitblame
    autocmd!
    " git blame 自动关闭（避免误触打开 blame 视图）
    autocmd CursorHold * nested if &ft ==# 'gitblame' | q | endif
augroup END

augroup vimcfg_fold
    autocmd!
    " Markdown 文件默认展开所有折叠（syntax foldmethod 会把标题内容折叠起来）
    autocmd FileType markdown setlocal foldlevel=99
augroup END
