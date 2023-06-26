参考代码：
GitHub: https://github.com/jdhao

lua-guide
https://neovim.io/doc/user/lua-guide.html

建议直接在.config 中创建软连接到git仓库中
ln -s ${HOME}/Projects/vimcfg/mNvimConfig ${HOME}/.config/nvim

第一次启动需要同步一下插件:
:PackerSync

需要手动安装 vim-language-server
:MasonInstall vim-language-server

需要新增语言服务时，可以在 config/mason.lua 中新增，也可以使用 MasonInstall <server> 安装
支持的语言可以在 https://github.com/williamboman/mason-lspconfig.nvim 查看
