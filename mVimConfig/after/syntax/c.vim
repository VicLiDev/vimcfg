" after/syntax/c.vim - 在所有 C 语法文件加载完毕后执行 ctags 类型高亮
if get(g:, 'ctags_type_highlight', 1)
    CtagsHighlight
endif
