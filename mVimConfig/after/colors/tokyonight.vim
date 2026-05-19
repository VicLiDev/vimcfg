" TokyoNight 自定义覆盖
" Vim 加载 colorscheme tokyonight 后会自动 source after/colors/tokyonight.vim
" 色值映射对应 gruvbox 自定义覆盖 (after/colors/gruvbox.vim) 中各 Gruvbox* 角色

" ----- 通用语法 -----
hi! Comment guifg=#6e719c ctermfg=244 ctermbg=none
hi! Exception guifg=#BB9AF7 ctermfg=180
hi! Operator guifg=#FF9E64 ctermfg=215

" ----- Vim -----
hi! vimFuncName guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
hi! vimUserFunc guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
hi! vimCommand guifg=#7DCFFF ctermfg=117
hi! vimOption guifg=#E0AF68 ctermfg=179

" ----- Shell -----
hi! shStatement guifg=#F7768E ctermfg=203
hi! shConditional guifg=#F7768E ctermfg=203
hi! shLoop guifg=#F7768E ctermfg=203
hi! shFunction guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
hi! shFunctionKey guifg=#F7768E ctermfg=203
hi! shSet guifg=#F7768E ctermfg=203
hi! shOperator guifg=#FF9E64 ctermfg=215
hi! shQuote guifg=#9ECE6A ctermfg=107
hi! shSingleQuote guifg=#9ECE6A ctermfg=107
hi! shDoubleQuote guifg=#9ECE6A ctermfg=107
hi! shVarAssign guifg=#FF9E64 ctermfg=215
hi! shVariable guifg=#E0AF68 ctermfg=179
hi! shDerefSimple guifg=#FF9E64 ctermfg=215
hi! shDeref guifg=#FF9E64 ctermfg=215
hi! shDerefVar guifg=#FF9E64 ctermfg=215
hi! shCmdSubRegion guifg=#a9b1d6 ctermfg=250
hi! shTestOpr guifg=#FF9E64 ctermfg=215
hi! shCaseEsac guifg=#F7768E ctermfg=203
hi! shCaseBar guifg=#7982a9 ctermfg=247

" ----- C/C++ -----
hi! cOperator guifg=#FF9E64 ctermfg=215
hi! cType guifg=#E0AF68 ctermfg=179
hi! cTagsType guifg=#E0AF68 ctermfg=179
hi! cStorageClass guifg=#FF9E64 ctermfg=215
hi! cQualifier guifg=#FF9E64 ctermfg=215
hi! cConstant guifg=#BB9AF7 ctermfg=180
hi! cPreCondit guifg=#7DCFFF ctermfg=117
hi! cInclude guifg=#7DCFFF ctermfg=117
hi! cDefine guifg=#7DCFFF ctermfg=117
hi! cUserFunction guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
hi! cTypeName guifg=#E0AF68 ctermfg=179
hi! cStructMember guifg=#9aa5ce ctermfg=248
hi! cBuiltinType guifg=#E0AF68 ctermfg=179
hi! cppAttribute guifg=#BB9AF7 ctermfg=180
hi! cppAttributeBrackets guifg=#7982a9 ctermfg=247
hi! cppBuiltinType guifg=#E0AF68 ctermfg=179
hi! cppSTLnamespace guifg=#7982a9 ctermfg=247
hi! cppSTLtype guifg=#E0AF68 ctermfg=179
hi! cppSTLtypedef guifg=#7DCFFF ctermfg=117
hi! cppSTLconstant guifg=#BB9AF7 ctermfg=180
hi! cppSTLbool guifg=#BB9AF7 ctermfg=180
hi! cppSTLfunction guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
hi! cppSTLenum guifg=#E0AF68 ctermfg=179
hi! cppSTLiterator guifg=#7DCFFF ctermfg=117
hi! cppSTLexception guifg=#BB9AF7 ctermfg=180
hi! cppSTLvariable guifg=#a9b1d6 ctermfg=250
hi! cppSTLdefine guifg=#7DCFFF ctermfg=117
hi! cppSTLios guifg=#7982a9 ctermfg=247

" ----- Python -----
hi! pythonBuiltin guifg=#E0AF68 ctermfg=179
hi! pythonBuiltinObj guifg=#E0AF68 ctermfg=179
hi! pythonBuiltinFunc guifg=#E0AF68 ctermfg=179
hi! pythonFunction guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
hi! pythonDecorator guifg=#BB9AF7 ctermfg=180
hi! pythonInclude guifg=#7DCFFF ctermfg=117
hi! pythonImport guifg=#7DCFFF ctermfg=117
hi! pythonRun guifg=#7DCFFF ctermfg=117
hi! pythonCoding guifg=#7DCFFF ctermfg=117
hi! pythonOperator guifg=#FF9E64 ctermfg=215
hi! pythonException guifg=#BB9AF7 ctermfg=180
hi! pythonDot guifg=#565f89 ctermfg=240

" ----- JavaScript -----
hi! javaScriptParens guifg=#7982a9 ctermfg=247
hi! javascriptEndColons guifg=#7982a9 ctermfg=247
hi! javascriptFuncArg guifg=#7982a9 ctermfg=247
hi! javascriptGlobalMethod guifg=#9ECE6A ctermfg=107
hi! javascriptNodeGlobal guifg=#9ECE6A ctermfg=107
hi! javascriptArrayMethod guifg=#9ECE6A ctermfg=107
hi! javascriptArrayStaticMethod guifg=#9ECE6A ctermfg=107
hi! javascriptCacheMethod guifg=#9ECE6A ctermfg=107
hi! javascriptDateMethod guifg=#9ECE6A ctermfg=107
hi! javascriptMathStaticMethod guifg=#9ECE6A ctermfg=107
hi! javascriptURLUtilsProp guifg=#9ECE6A ctermfg=107
hi! javascriptBOMLocationMethod guifg=#9ECE6A ctermfg=107
hi! javascriptBOMWindowMethod guifg=#9ECE6A ctermfg=107
hi! javascriptStringMethod guifg=#9ECE6A ctermfg=107
hi! javascriptDOMDocMethod guifg=#9ECE6A ctermfg=107
hi! javascriptDOMEventMethod guifg=#9ECE6A ctermfg=107
hi! javascriptDOMNodeMethod guifg=#9ECE6A ctermfg=107
hi! javascriptDOMStorageMethod guifg=#9ECE6A ctermfg=107
hi! javascriptHeadersMethod guifg=#9ECE6A ctermfg=107
hi! javascriptBOMWindowProp guifg=#7982a9 ctermfg=247
hi! javascriptBOMNavigatorProp guifg=#7982a9 ctermfg=247
hi! javascriptDOMDocProp guifg=#7982a9 ctermfg=247
hi! javascriptDOMElemAttrs guifg=#7982a9 ctermfg=247
hi! javascriptProp guifg=#7982a9 ctermfg=247
hi! javascriptOperator guifg=#FF9E64 ctermfg=215
hi! javascriptYield guifg=#BB9AF7 ctermfg=180
hi! javascriptExceptions guifg=#BB9AF7 ctermfg=180
hi! javascriptTemplateSubstitution guifg=#7982a9 ctermfg=247
hi! javascriptLabel guifg=#7982a9 ctermfg=247
hi! javascriptObjectLabel guifg=#7982a9 ctermfg=247
hi! javascriptPropertyName guifg=#7982a9 ctermfg=247
hi! javascriptLogicSymbols guifg=#7982a9 ctermfg=247
hi! javascriptBrackets guifg=#7982a9 ctermfg=247
hi! javascriptAsyncFuncKeyword guifg=#7DCFFF ctermfg=117
hi! javascriptAwaitFuncKeyword guifg=#7DCFFF ctermfg=117

" ----- PanglossJS -----
hi! jsGlobalNodeObjects guifg=#E0AF68 ctermfg=179
hi! jsGlobalObjects guifg=#E0AF68 ctermfg=179
hi! jsFuncParens guifg=#7982a9 ctermfg=247
hi! jsParens guifg=#7982a9 ctermfg=247

" ----- Markdown -----
hi! markdownItalic guifg=#7982a9 ctermfg=247
" 标题: 暖到冷渐变 (橙->黄->绿->青->蓝->紫)，层级递减
hi! markdownH1 guifg=#FF9E64 ctermfg=215 gui=bold cterm=bold
hi! markdownH2 guifg=#E0AF68 ctermfg=179 gui=bold cterm=bold
hi! markdownH3 guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
hi! markdownH4 guifg=#7DCFFF ctermfg=117 gui=bold cterm=bold
hi! markdownH5 guifg=#7AA2F7 ctermfg=110
hi! markdownH6 guifg=#BB9AF7 ctermfg=180
hi! markdownCode guifg=#7DCFFF ctermfg=117
hi! markdownCodeBlock guifg=#7DCFFF ctermfg=117
hi! markdownCodeDelimiter guifg=#7DCFFF ctermfg=117
hi! markdownBlockquote guifg=#444B6A ctermfg=60
hi! markdownListMarker guifg=#444B6A ctermfg=60
hi! markdownOrderedListMarker guifg=#444B6A ctermfg=60
hi! markdownRule guifg=#444B6A ctermfg=60
hi! markdownHeadingRule guifg=#444B6A ctermfg=60
hi! markdownUrlDelimiter guifg=#7982a9 ctermfg=247
hi! markdownLinkDelimiter guifg=#7982a9 ctermfg=247
hi! markdownLinkTextDelimiter guifg=#7982a9 ctermfg=247
hi! markdownUrl guifg=#BB9AF7 ctermfg=180
hi! markdownUrlTitleDelimiter guifg=#7982a9 ctermfg=247
hi! markdownLinkText guifg=#7982a9 ctermfg=247
hi! markdownIdDeclaration guifg=#7982a9 ctermfg=247

" ----- NERDTree -----
" 目录与可执行文件：粗体绿
hi! NERDTreeDir guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
" 目录箭头/标志：柔和灰
hi! NERDTreeDirArrow guifg=#565f89 ctermfg=240
hi! NERDTreeUp guifg=#444B6A ctermfg=60
" 当前打开的文件：醒目橙
hi! NERDTreeOpenable guifg=#FF9E64 ctermfg=215
hi! NERDTreeClosable guifg=#FF9E64 ctermfg=215
" 只读文件：红色
hi! NERDTreeRO guifg=#F7768E ctermfg=203
" 可执行文件：青色
hi! NERDTreeExecFile guifg=#7DCFFF ctermfg=117
" 符号链接：紫色
hi! NERDTreeLinkFile guifg=#BB9AF7 ctermfg=180
hi! NERDTreeLinkTarget guifg=#7982a9 ctermfg=247
" 书签：黄色
hi! NERDTreeBookmark guifg=#E0AF68 ctermfg=179
" 标题/帮助行：柔和灰
hi! NERDTreeHelp guifg=#444B6A ctermfg=60
hi! NERDTreeToggleOn guifg=#9ECE6A ctermfg=107
hi! NERDTreeToggleOff guifg=#7982a9 ctermfg=247
" 分隔符
hi! NERDTreeCWD guifg=#7DCFFF ctermfg=117
hi! NERDTreeFlags guifg=#FF9E64 ctermfg=215
" 文件匹配（模糊搜索）
hi! NERDTreeFile guifg=#a9b1d6 ctermfg=250

" ----- TagList -----
" 文件名：青色粗体（与 NERDTreeCWD 统一风格）
hi! TagListFileName guifg=#7DCFFF ctermfg=117 gui=bold cterm=bold guibg=#16161e ctermbg=234
" 标签名（函数/变量等）：绿色粗体（与函数高亮统一）
hi! TagListTagName guifg=#9ECE6A ctermfg=107 gui=bold cterm=bold
" 分类标题（functions、variables 等）：橙色
hi! TagListTitle guifg=#E0AF68 ctermfg=179 gui=bold cterm=bold
" 注释行：暗灰
hi! TagListComment guifg=#444B6A ctermfg=60
" 作用域 [ClassName]：柔和灰蓝
hi! TagListTagScope guifg=#7982a9 ctermfg=247

" ----- vim-startify -----
" StartifyNumber 会匹配到 # 开头的行，去掉其背景色
hi! StartifyNumber ctermbg=none

" ----- vimdiff 莫兰迪色系 -----
" 灰调中饱和度，可辨识且不刺眼
" 层级: DiffText(最突出) > DiffAdd/DiffChange/DiffDelete(行底色)
" 新增行: 蓝灰（与 illuminate 高亮错开，避免撞色）
hi! DiffAdd    guifg=NONE guibg=#26383B ctermfg=NONE ctermbg=24
" 修改行: 暖灰黄（底色，柔和）
hi! DiffChange guifg=NONE guibg=#3A3826 ctermfg=NONE ctermbg=238
" 删除行: 干燥玫瑰
hi! DiffDelete guifg=NONE guibg=#5A343C ctermfg=NONE ctermbg=52
" 修改文本: 金橄榄（在 DiffChange 黄底上更亮更饱和 + 粗体）
hi! DiffText  guifg=NONE guibg=#5C5628 ctermfg=NONE ctermbg=58 gui=bold cterm=bold