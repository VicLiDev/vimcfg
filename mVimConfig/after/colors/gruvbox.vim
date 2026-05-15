" Gruvbox 自定义覆盖
" Vim 加载 colorscheme gruvbox 后会自动 source after/colors/gruvbox.vim

" ----- 通用语法 -----
hi! link Exception GruvboxPurple
hi! link Operator GruvboxOrange

" ----- Vim -----
hi! link vimFuncName GruvboxGreenBold
hi! link vimUserFunc GruvboxGreenBold
hi! link vimCommand GruvboxAqua
hi! link vimOption GruvboxYellow

" ----- Shell -----
hi! link shStatement GruvboxRed
hi! link shConditional GruvboxRed
hi! link shLoop GruvboxRed
hi! link shFunction GruvboxGreenBold
hi! link shFunctionKey GruvboxRed
hi! link shSet GruvboxRed
hi! link shOperator GruvboxOrange
hi! link shQuote GruvboxGreen
hi! link shSingleQuote GruvboxGreen
hi! link shDoubleQuote GruvboxGreen
hi! link shVarAssign GruvboxOrange
hi! link shVariable GruvboxYellow
hi! link shDerefSimple GruvboxOrange
hi! link shDeref GruvboxOrange
hi! link shDerefVar GruvboxOrange
hi! link shCmdSubRegion GruvboxFg1
hi! link shTestOpr GruvboxOrange
hi! link shCaseEsac GruvboxRed
hi! link shCaseBar GruvboxFg3

" ----- C/C++ -----
hi! link cOperator GruvboxOrange
hi! link cType GruvboxYellow
hi! link cTagsType GruvboxYellow
hi! link cStorageClass GruvboxOrange
hi! link cQualifier GruvboxOrange
hi! link cConstant GruvboxPurple
hi! link cPreCondit GruvboxAqua
hi! link cInclude GruvboxAqua
hi! link cDefine GruvboxAqua
hi! link cUserFunction GruvboxGreenBold
hi! link cTypeName GruvboxYellow
hi! link cStructMember GruvboxFg2
hi! link cBuiltinType GruvboxYellow
hi! link cppAttribute GruvboxPurple
hi! link cppAttributeBrackets GruvboxFg3
hi! link cppBuiltinType GruvboxYellow
hi! link cppSTLnamespace GruvboxFg3
hi! link cppSTLtype GruvboxYellow
hi! link cppSTLtypedef GruvboxAqua
hi! link cppSTLconstant GruvboxPurple
hi! link cppSTLbool GruvboxPurple
hi! link cppSTLfunction GruvboxGreenBold
hi! link cppSTLenum GruvboxYellow
hi! link cppSTLiterator GruvboxAqua
hi! link cppSTLexception GruvboxPurple
hi! link cppSTLvariable GruvboxFg1
hi! link cppSTLdefine GruvboxAqua
hi! link cppSTLios GruvboxFg3

" ----- Python -----
hi! link pythonBuiltin GruvboxYellow
hi! link pythonBuiltinObj GruvboxYellow
hi! link pythonBuiltinFunc GruvboxYellow
hi! link pythonFunction GruvboxGreenBold
hi! link pythonDecorator GruvboxPurple
hi! link pythonInclude GruvboxAqua
hi! link pythonImport GruvboxAqua
hi! link pythonRun GruvboxAqua
hi! link pythonCoding GruvboxAqua
hi! link pythonOperator GruvboxOrange
hi! link pythonException GruvboxPurple
hi! link pythonDot GruvboxFg4

" ----- JavaScript -----
hi! link javaScriptParens GruvboxFg3
hi! link javascriptEndColons GruvboxFg3
hi! link javascriptFuncArg GruvboxFg3
hi! link javascriptGlobalMethod GruvboxGreen
hi! link javascriptNodeGlobal GruvboxGreen
hi! link javascriptArrayMethod GruvboxGreen
hi! link javascriptArrayStaticMethod GruvboxGreen
hi! link javascriptCacheMethod GruvboxGreen
hi! link javascriptDateMethod GruvboxGreen
hi! link javascriptMathStaticMethod GruvboxGreen
hi! link javascriptURLUtilsProp GruvboxGreen
hi! link javascriptBOMLocationMethod GruvboxGreen
hi! link javascriptBOMWindowMethod GruvboxGreen
hi! link javascriptStringMethod GruvboxGreen
hi! link javascriptDOMDocMethod GruvboxGreen
hi! link javascriptDOMEventMethod GruvboxGreen
hi! link javascriptDOMNodeMethod GruvboxGreen
hi! link javascriptDOMStorageMethod GruvboxGreen
hi! link javascriptHeadersMethod GruvboxGreen
hi! link javascriptBOMWindowProp GruvboxFg3
hi! link javascriptBOMNavigatorProp GruvboxFg3
hi! link javascriptDOMDocProp GruvboxFg3
hi! link javascriptDOMElemAttrs GruvboxFg3
hi! link javascriptProp GruvboxFg3
hi! link javascriptOperator GruvboxOrange
hi! link javascriptYield GruvboxPurple
hi! link javascriptExceptions GruvboxPurple
hi! link javascriptTemplateSubstitution GruvboxFg3
hi! link javascriptLabel GruvboxFg3
hi! link javascriptObjectLabel GruvboxFg3
hi! link javascriptPropertyName GruvboxFg3
hi! link javascriptLogicSymbols GruvboxFg3
hi! link javascriptBrackets GruvboxFg3
hi! link javascriptAsyncFuncKeyword GruvboxAqua
hi! link javascriptAwaitFuncKeyword GruvboxAqua

" ----- PanglossJS -----
hi! link jsGlobalNodeObjects GruvboxYellow
hi! link jsGlobalObjects GruvboxYellow
hi! link jsFuncParens GruvboxFg3
hi! link jsParens GruvboxFg3

" ----- Markdown -----
hi! link markdownItalic GruvboxFg3
" 标题: 暖到冷渐变 (橙->黄->绿->青->蓝->紫)，层级递减
hi! link markdownH1 GruvboxOrangeBold
hi! link markdownH2 GruvboxYellowBold
hi! link markdownH3 GruvboxGreenBold
hi! link markdownH4 GruvboxAquaBold
hi! link markdownH5 GruvboxBlue
hi! link markdownH6 GruvboxPurple
hi! link markdownCode GruvboxAqua
hi! link markdownCodeBlock GruvboxAqua
hi! link markdownCodeDelimiter GruvboxAqua
hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray
hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3
hi! link markdownUrl GruvboxPurple
hi! link markdownUrlTitleDelimiter GruvboxFg3
hi! link markdownLinkText GruvboxFg3
hi! link markdownIdDeclaration markdownLinkText

" ----- NERDTree -----
" 目录与可执行文件：粗体绿
hi! link NERDTreeDir GruvboxGreenBold
" 目录箭头/标志：柔和灰
hi! link NERDTreeDirArrow GruvboxFg4
hi! link NERDTreeUp GruvboxGray
" 当前打开的文件：醒目橙
hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange
" 只读文件：红色
hi! link NERDTreeRO GruvboxRed
" 可执行文件：青色
hi! link NERDTreeExecFile GruvboxAqua
" 符号链接：紫色
hi! link NERDTreeLinkFile GruvboxPurple
hi! link NERDTreeLinkTarget GruvboxFg3
" 书签：黄色
hi! link NERDTreeBookmark GruvboxYellow
" 标题/帮助行：柔和灰
hi! link NERDTreeHelp GruvboxGray
hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxFg3
" 分隔符
hi! link NERDTreeCWD GruvboxAqua
hi! link NERDTreeFlags GruvboxOrange
" 文件匹配（模糊搜索）
hi! link NERDTreeFile GruvboxFg1
