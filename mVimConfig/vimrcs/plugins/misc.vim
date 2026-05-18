" ── Misc Plugins ────────────────────────────────────────

" ── oscyank（远程剪贴板）──────────────────────────────
" 已在 snippet.vim 中配置映射，此处仅加载插件。

" ── easymotion（快速跳转）──────────────────────────────
" 映射已在 search.vim 中配置，此处仅加载插件。

" ── tabular（文本对齐）────────────────────────────────
" 无需额外配置，开箱即用。
" 常用命令：
"   :Tab /=    按 = 对齐
"   :Tab/:     按 : 对齐

" ── commentary（注释切换）─────────────────────────────
" 无需额外配置，开箱即用。
" 常用命令：
"   gcc        切换当前行注释
"   gc{motion} 切换选中区域注释

" ── vim-mark（标记高亮）───────────────────────────────
nmap <Leader>mc <Plug>MarkAllClear

" ── indent-guides（缩进引导线）────────────────────────
" 注意：此插件与 indentLine 功能重叠，indentLine 优先使用。
" 如需使用 indent-guides 替代 indentLine，请注释掉 ui.vim 中的 indentLine 配置。
