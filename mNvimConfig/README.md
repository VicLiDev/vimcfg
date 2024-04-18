参考代码：
GitHub: 
https://github.com/jdhao/nvim-config

lua-guide
https://neovim.io/doc/user/lua-guide.html

# 使用方法

建议直接在.config 中创建软连接到git仓库中
ln -s ${HOME}/Projects/vimcfg/mNvimConfig ${HOME}/.config/nvim

第一次启动需要同步一下插件:
:PackerSync

如果使用遇到问题，可能需要读一下doc下的文档

需要手动安装 vim-language-server
:MasonInstall vim-language-server

需要新增语言服务时，可以在 config/mason.lua 中新增，也可以使用 MasonInstall <server> 安装
支持的语言可以在 https://github.com/williamboman/mason-lspconfig.nvim 查看

安装coc需要做如下操作：
brew install nodejs
npm install yarn
cd ~/.local/share/nvim/site/pack/packer/start/coc.nvim
yarn install
yarn build

# 配置脚本开发的说明

nvim的配置目录在 ~/.config/nvim/init.vim 下，如果没有，可以自己创建，配置脚本使用lua语言

## lua 语言介绍

### pcall

pcall 的基本用法如下：
```lua
status, result = pcall(func, arg1, arg2, ...)
```
* status：一个布尔值，指示函数是否成功执行。如果函数成功执行，status 为 true；
          如果函数执行过程中发生错误，status 为 false。
* result：如果 status 为 true，则 result 包含函数的返回值。如果 status 为 false，
          则 result 包含错误消息。
* func：要调用的函数。
* arg1, arg2, ...：传递给 func 的参数。


### 模块（包）加载机制

对于自定义的模块，模块文件不是放在哪个文件目录都行，函数 require 有它自己的文件
路径加载策略，它会尝试从 Lua 文件或 C 程序库中加载模块。

require 用于搜索 Lua 文件的路径是存放在全局变量 package.path 中，当 Lua 启动后，
会以环境变量 LUA_PATH 的值来初始这个环境变量。如果没有找到该环境变量，则使用一个
编译时定义的默认路径来初始化。

当然，如果没有 LUA_PATH 这个环境变量，也可以自定义设置，在当前用户根目录下打开
.profile 文件（没有则创建，打开 .bashrc 文件也可以），例如把 "~/lua/" 路径加入
LUA_PATH 环境变量里：
```
#LUA_PATH
export LUA_PATH="~/lua/?.lua;;"
````
文件路径以 ";" 号分隔，最后的 2 个 ";;" 表示新加的路径后面加上原来的默认路径。

## init.lua说明

在init.lua 中，会指定当前配置支持的nvim版本，然后与当前nvim实际的版本进行比较，
其中version.parse(expected_ver)可以将字符串转为table，便于后续进行比较

init.lua 中会使用 core_conf_files table指定要加载的脚本，然后for循环依次加载
所有 Vim 命令和功能都可以从 Lua 使用，需要调用vim.cmd，对应的命令以字符串的形式
作为vim.cmd 的入参

## core 脚本介绍

* globals.lua      -- 一些全局配置，例如快捷键leader等
* options.vim      -- nvim中的配置项
* autocommands.vim -- 各种 autocmd，例如自动补全括号，自动插入文件头等
* mappings.lua     -- 用户自定义的一些快捷键映射，主要是针对nvim内置的可映射功能
* plugins.vim      -- 所有的插件和对应的配置，包括插件的快捷键映射等
* colorschemes.lua -- 主题相关的配置

### plugins.vim 解析

在 plugins.vim中，会加载并执行 lua/plugins.lua，在 lua/plugins.lua 中，会进一步
配置各个插件，插件的配置文件在 lua/config 下

pakcer 管理的插件存放在 ~/.local/share/nvim/site/pack/packer 下
