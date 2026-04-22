" 插件列表文件，供 Vundle 和 vim-plug 共享
" 修改插件只需编辑此文件

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'zivyangll/git-blame.vim'
" 在行号旁显示git diff标记（+/-），实时查看哪些行被修改/新增/删除
Plugin 'airblade/vim-gitgutter'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" ================================ my plugin begin

" Startup interface and management
Plugin 'mhinz/vim-startify'


" File browsing and management
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'vim-scripts/taglist.vim'
" Plugin 'majutsushi/tagbar'
Plugin 'preservim/tagbar'


" Editor Enhancements
" 缩紧
Plugin 'Yggdroot/indentLine'
" 快速移动
Plugin 'easymotion/vim-easymotion'
Plugin 'rhysd/accelerated-jk'
" 在 Vim 中打开网页链接
Plugin 'tyru/open-browser.vim'
" comment
Plugin 'tpope/vim-commentary'
" multi high color
Plugin 'inkarkat/vim-ingo-library'
Plugin 'inkarkat/vim-mark'

" 剪贴板历史栈，可以回溯之前复制/删除的内容
Plugin 'maxbrunsfeld/vim-yankstack'


" Code completion and smart editing
" ycm-core/YouCompleteMe 和 Valloric/YouCompleteMe 其实是同一个项目的不同组织者。
" 最初，这个项目是由 Valloric 创建和维护的，但后来为了更好的管理和协作，项目转移
" 到了 ycm-core 这个组织下。
" Valloric/YouCompleteMe 是项目的原始存储库。
" ycm-core/YouCompleteMe 是当前的维护组织，可能会包含更多的贡献者和更活跃的开发。
" ycm-core/YouCompleteMe 可能包含最新的功能和修复，因为它是目前维护的版本。
"
" 遇到问题：
" 支持vim9.1，可以手动将其退到必须vim9.1之前，直接在log里搜索9.1尝试
" 安装：python ./install.py --all
"
" 遇到go环境的问题，重新安装go：
" 从https://go.dev/dl/ 下载想要的版本，例如1.23.2
" 解压到 go_1.23.2
" mv go_1.23.2 /usr/local/go/
" sudo ln -s /usr/local/go/go_1.23.2/bin/go /usr/bin/go
" .bashrc中添加
" export GOROOT=/usr/local/go
" export GOPATH=$HOME/go
" export PATH=$PATH:$GOROOT/bin
"
if has('win32') || has('linux')
    " YCM 使用完整克隆，保留 git 历史以便查看版本和更新
    " shallow=0: 禁用浅克隆（默认 --depth 1 只拉取最近一个 commit），完整克隆所有历史
    Plugin 'ycm-core/YouCompleteMe', {'shallow': 0}
endif
" Plugin 'neoclide/coc.nvim'

" Language Server and Code Analysis
" 语言服务器协议（LSP）客户端插件，LSP（Language Server Protocol）是一个标准化
" 协议，用于在编辑器和编程语言服务器之间交换信息，提供代码补全、跳转、诊断信息等
" 功能。
" 通过 LanguageClient-neovim 插件，你可以在 Neovim 中启用类似于现代 IDE 的功能，
" 如语法检查、自动补全、代码导航、重构等，而无需依赖特定的编辑器或 IDE。
if has('win32') || has('linux')
    Plugin 'https://github.com/autozimu/LanguageClient-neovim'
elseif has('mac')
endif


" 异步语法检查和linting工具，支持多种语言，比YCM的lint更轻量
Plugin 'dense-analysis/ale'


" Code snippet management and expansion
" 代码片段（snippets）管理和插入
" UltiSnips 是一个强大的代码片段引擎，提供完整的片段管理、动态扩展、跳转等
" 功能，支持用户定义和创建复杂的代码片段。
" vim-snippets 主要是一个代码片段集合库，提供现成的片段资源，通常与其他插件
" （如 UltiSnips）一起使用，用于增强代码片段的扩展和动态功能。
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'


" LaTeX and document processing
Plugin 'lervag/vimtex'


" Syntax highlighting and language support
if has('mac')
    Plugin 'sheerun/vim-polyglot'
endif


" Theme and interface
" Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" align text
Plugin 'godlygeek/tabular'

" Markdown editing and preview
" Markdown 语法高亮、折叠、快捷操作
Plugin 'preservim/vim-markdown'
" 自动生成目录（TOC）
" 比如：
"   <!-- vim-markdown-toc -->
"   ...
"   <!-- vim-markdown-toc -->
Plugin 'mzlogin/vim-markdown-toc'
" 给 markdown-preview 增强数学公式支持
Plugin 'iamcco/mathjax-support-for-mkdp'
" 浏览器实时预览 Markdown
Plugin 'iamcco/markdown-preview.vim'


" PlantUML support
Plugin 'aklt/plantuml-syntax'
Plugin 'weirongxu/plantuml-previewer.vim'
Plugin 'scrooloose/vim-slumlord'
Plugin 'skanehira/preview-uml.vim'


" Clipboard and Sharing
" share clipboard with vim
Plugin 'ojroques/vim-oscyank'

" ================================ my plugin end
