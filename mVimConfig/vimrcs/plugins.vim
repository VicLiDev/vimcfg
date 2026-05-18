" ── Plugin Configurations ──────────────────────────────
" Entry point: sources all plugin config files from plugins/ subdirectory.
" Each file corresponds to a functional domain:
"   ui      – startify, airline, nerdtree, devicons, illuminate, lastplace
"   search  – ctrlp, fzf, ack/ag/grep, tagbar, gtags
"   git     – fugitive, gitgutter, blame
"   code    – YCM, ALE, ctags, surround, camelcasemotion, smartrename
"   snippet – ultisnips, yankstack, peekaboo
"   lang    – vimtex, markdown, plantuml, json, yaml
"   misc    – oscyank, easymotion, tabular, commentary, mark

" 关闭 ctags 自定义类型高亮
let g:ctags_type_highlight = 0

for s:f in ['ui', 'search', 'git', 'code', 'snippet', 'lang', 'misc']
  execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/plugins/' . s:f . '.vim'
endfor
