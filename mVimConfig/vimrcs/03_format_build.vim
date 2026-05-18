" ── Format & Build Tools ──────────────────────────────

" ── 行尾空格清理 ──────────────────────────────────────
" 删除行尾多余空白字符（包括空格和制表符）
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
endfunction
autocmd BufWritePre * :call CleanExtraSpaces()

" ── 代码格式化 ────────────────────────────────────────
" 使用4个空格缩进并设置K&R风格的括号
" command! FormatCode execute 'silent! %!astyle --style=kr --indent=spaces=4'

" autocmd BufWritePre *.c,*.cpp,*.h,*.hpp execute 'silent! %!astyle'

" 自定义一个命令
" command! FormatCode execute 'silent! %!astyle --style=kr --indent=spaces=4'
command! FormatCode execute 'silent! %!astyle'
