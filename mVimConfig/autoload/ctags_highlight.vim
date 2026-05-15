" autoload/ctags_highlight.vim - ctags 类型高亮核心逻辑
" 通过 after/syntax/c.vim 和 after/syntax/cpp.vim 自动触发
" 使用 :CtagsHighlight 手动刷新，:CtagsHighlightClear 清除高亮
" 实际触发点在 after/syntax/c.vim 和 after/syntax/cpp.vim（确保在所有语法文件之后执行）
" 注意：此方案是语法层面的着色，不依赖 LSP，与 clangd 互不冲突
" 设置 g:ctags_type_highlight=0 可关闭此功能

let s:cache = {}
let s:cache_mtime = {}
let s:loaded = 0

function! ctags_highlight#parse_types(tags_file) abort
    if !filereadable(a:tags_file)
        return []
    endif
    " 缓存检查：tags 文件未修改时跳过解析
    let l:mtime = getftime(a:tags_file)
    if get(s:cache_mtime, a:tags_file, -1) == l:mtime
        \ && has_key(s:cache, a:tags_file)
        return s:cache[a:tags_file]
    endif
    let l:types = []
    let l:type_kinds = {'s': 1, 'u': 1, 'g': 1, 't': 1, 'c': 1}
    " 仅提取 C/C++ 源文件中的类型
    let l:c_exts = '\.\(c\|h\|cpp\|cc\|hpp\|cxx\|cu\)$'
    for l:line in readfile(a:tags_file, '', 100000)
        if l:line =~# '^!'
            continue
        endif
        let l:fields = split(l:line, "\t", 1)
        if len(l:fields) < 4
            continue
        endif
        " fields[0]=tagname, fields[1]=file, fields[2]=pattern, fields[3]=kind
        if !has_key(l:type_kinds, l:fields[3])
            continue
        endif
        if l:fields[1] !~# l:c_exts
            continue
        endif
        let l:name = l:fields[0]
        if l:name !~# '^\w'
            continue
        endif
        call add(l:types, l:name)
    endfor
    let l:types = uniq(sort(l:types))
    let s:cache[a:tags_file] = l:types
    let s:cache_mtime[a:tags_file] = l:mtime
    return l:types
endfunction

function! ctags_highlight#apply() abort
    if !get(g:, 'ctags_type_highlight', 1)
        return
    endif
    " 每个 session 只加载一次，避免每次打开文件重复解析 tags
    if s:loaded
        return
    endif
    silent! syntax clear cTagsType
    let l:all_types = []
    " 使用 tagfiles() 获取 Vim 已加载的 tags 文件路径（正确处理 ; 向上搜索）
    for l:tags_path in tagfiles()
        call extend(l:all_types, ctags_highlight#parse_types(l:tags_path))
    endfor
    if empty(l:all_types)
        return
    endif
    let l:all_types = uniq(sort(l:all_types))
    " syntax keyword 有长度限制，分批添加（每批约 8000 字符）
    let l:batch = []
    let l:batch_len = 0
    for l:t in l:all_types
        call add(l:batch, l:t)
        let l:batch_len += len(l:t) + 1
        if l:batch_len >= 8000
            execute 'syntax keyword cTagsType ' . join(l:batch)
            let l:batch = []
            let l:batch_len = 0
        endif
    endfor
    if !empty(l:batch)
        execute 'syntax keyword cTagsType ' . join(l:batch)
    endif
    hi! link cTagsType Type
    let s:loaded = 1
endfunction

function! ctags_highlight#refresh() abort
    let s:loaded = 0
    call ctags_highlight#apply()
endfunction

function! ctags_highlight#clear() abort
    silent! syntax clear cTagsType
    let s:loaded = 0
endfunction
