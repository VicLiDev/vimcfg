# Vim 配置说明

## 插件管理器架构

### 核心思路

通过将插件声明与管理器初始化分离，实现**一个插件列表文件同时供 Vundle 和 vim-plug 使用**，切换管理器时无需修改插件列表。

### 文件结构

```
vimrcs/
├── plugin_manager.vim    # 符号链接 → pm_vundle.vim 或 pm_vimplug.vim
├── pm_vundle.vim         # Vundle 初始化 + source plugins_list.vim
├── pm_vimplug.vim        # vim-plug 初始化 + alias Plugin→Plug + source plugins_list.vim
├── plugins_list.vim      # 所有 Plugin 'xxx' 声明（唯一的插件清单）
├── commoncfg.vim         # 通用编辑器配置（编码、缩进、映射等）
└── plugins.vim           # 各插件的详细配置（快捷键、选项等）
```

### 加载流程

```
vimrc
 │
 ├── source plugin_manager.vim   ← 符号链接，决定用哪个管理器
 │    │
 │    ├── [pm_vundle.vim]        [pm_vimplug.vim]
 │    │     │                        │
 │    │     set nocompatible        set nocompatible
 │    │     filetype off            command! Plugin → Plug  ← 关键：将 Plugin 别名为 Plug
 │    │     set rtp+=Vundle.vim     call plug#begin()
 │    │     call vundle#begin()     │
 │    │     │                       │
 │    │     └── source plugins_list.vim ──┘
 │    │             │
 │    │             Plugin 'VundleVim/Vundle.vim'
 │    │             Plugin 'tpope/vim-fugitive'
 │    │             Plugin 'airblade/vim-gitgutter'
 │    │             ...（所有插件声明）
 │    │
 │    ├── call vundle#end() / call plug#end()
 │    └── filetype plugin indent on   ← 此时才开启文件类型检测
 │
 ├── source commoncfg.vim           ← 管理器加载完成后，配置通用选项
 │
 └── source plugins.vim             ← 各插件的具体配置（快捷键、选项等）
```

### 关键原理

1. **plugin_manager.vim 必须最先加载**：Vundle 和 vim-plug 都要求在 begin/end 之间声明插件，且需要先 `filetype off`、后 `filetype plugin indent on`。

2. **Vundle 原生支持 Plugin 命令**：Vundle 的插件声明命令就是 `Plugin 'author/repo'`，plugins_list.vim 中的写法天然兼容。

3. **vim-plug 通过别名兼容**：`command! -nargs=+ Plugin Plug <args>` 将 `Plugin` 映射到 `Plug`，同时 `PluginInstall`/`PluginUpdate`/`PluginClean` 也做了别名。

### 切换管理器

```bash
# 使用 Vundle
ln -sf pm_vundle.vim plugin_manager.vim

# 使用 vim-plug
ln -sf pm_vimplug.vim plugin_manager.vim
```

或运行 `init.sh`，选择 vim 时会提示选择管理器并自动创建链接。

### 安装与部署

```bash
bash init.sh
# 选择 1) vim → 选择管理器 → 自动创建链接、检测系统工具、安装插件
```

- 系统工具（ctags/cscope/gtags）缺少时会提示：`sudo apt-get install universal-ctags cscope global`
- YouCompleteMe 额外步骤：在插件目录下执行 `python ./install.py --all`

---

## 快捷键与操作参考

### vim 自带操作

#### 切换标签页

| 命令                     | 说明             |
|--------------------------|------------------|
| `:tabnew [++opt] [file]` | 建立新 tab       |
| `:tabc`                  | 关闭当前 tab     |
| `:tabo`                  | 关闭所有其他 tab |
| `:tabs`                  | 查看所有 tab     |
| `:tabp` / `gT`           | 前一个 tab       |
| `:tabn` / `gt`           | 后一个 tab       |

---

### NERDTree

| 命令              | 说明                                |
|-------------------|-------------------------------------|
| `:NERDTree`       | 打开                                |
| `:NERDTreeClose`  | 关闭                                |
| `:NERDTreeToggle` | 切换                                |
| `Ctrl+n`          | 映射快捷键（在 plugins.vim 中配置） |

**文件/目录操作：**

| 快捷键     | 说明                             |
|------------|----------------------------------|
| `o`        | 打开文件/目录                    |
| `t` / `T`  | 在新 Tab 打开（跳转/不跳转）     |
| `i` / `gi` | 水平分屏打开（跳转/不跳转）      |
| `s` / `gs` | 垂直分屏打开（跳转/不跳转）      |
| `O`        | 递归打开目录                     |
| `x` / `X`  | 合拢目录                         |
| `P` / `p`  | 跳到根/父结点                    |
| `C`        | 设当前目录为根                   |
| `r` / `R`  | 刷新当前/根目录                  |
| `m`        | 文件系统菜单（ma 创建，md 删除） |
| `I`        | 显示/隐藏隐藏文件                |
| `q`        | 关闭 NERDTree                    |

---

### CtrlP

| 快捷键                      | 说明                             |
|-----------------------------|----------------------------------|
| `<c-p>`                     | 模糊搜索文件                     |
| `<c-f>` / `<c-b>`           | 切换模式（file/buffer/mru）      |
| `<c-r>`                     | 正则表达式模式                   |
| `<c-d>`                     | 仅文件名搜索                     |
| `<c-j>` / `<c-k>`           | 上下选择                         |
| `<c-t>` / `<c-v>` / `<c-x>` | 新 tab / 水平分屏 / 垂直分屏打开 |
| `<c-z>`                     | 标记多个文件                     |
| `<leader>fu`                | 函数搜索（ctrlp-funky）          |
| `<leader>fU`                | 搜索光标下单词的函数             |

---

### Taglist

| 命令                  | 说明              |
|-----------------------|-------------------|
| `<leader>tt`          | 打开/关闭 taglist |
| `<CR>`                | 跳转到 tag 定义   |
| `o`                   | 新窗口显示 tag    |
| `<Space>`             | 显示 tag 原型     |
| `s`                   | 切换排序方式      |
| `x`                   | 放大/缩小窗口     |
| `+` / `-` / `*` / `=` | 折叠操作          |

---

### ctags

生成 tags 文件：

```bash
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
```

常用操作：

| 快捷键        | 说明                             |
|---------------|----------------------------------|
| `Ctrl+]`      | 跳转到函数/结构体定义            |
| `Ctrl+T`      | 返回                             |
| `gd`          | 跳转到局部变量定义（当前函数内） |
| `gD`          | 跳转到单词首次使用处             |
| `:ts`         | 列出匹配 tag                     |
| `:tn` / `:tp` | 下一个/上一个匹配 tag            |

---

### cscope

生成索引：

```bash
find . -name "*.c" -o -name "*.h" -o -name "*.cpp" > cscope.files
cscope -Rbkq -i cscope.files
```

查询命令（`:cs f <字母>` 或 `<leader>cf`）：

| 字母 | 说明                 |
|------|----------------------|
| `s`  | 查找 C 符号          |
| `g`  | 查找定义             |
| `c`  | 查找调用本函数的函数 |
| `d`  | 查找本函数调用的函数 |
| `e`  | egrep 模式查找       |
| `f`  | 查找文件             |
| `i`  | 查找包含本文件的文件 |
| `t`  | 查找字符串           |

---

### gtags

与 vim 配合通过 `gtags.vim`（在 vimrcs/gtags.vim 中）：

| 命令                | 说明              |
|---------------------|-------------------|
| `:Gtags <pattern>`  | 搜索 tag          |
| `:Gtagsa <pattern>` | 搜索并附加结果    |
| `:GtagsCursor`      | 搜索光标下单词    |
| `:GtagsUpdate`      | 更新 gtags 数据库 |

---

### 配色

推荐配色：

- [gruvbox](https://github.com/morhetz/gruvbox)
- [molokai](https://github.com/tomasr/molokai)
- [seoul256](https://github.com/junegunn/seoul256.vim)
- [solarized](https://github.com/altercation/vim-colors-solarized)

安装：将 `.vim` 文件复制到 `~/.vim/colors/`，然后用 `:colorscheme <name>` 设置。

---

### tmux

参考：https://www.ruanyifeng.com/blog/2019/10/tmux.html

**基本操作：**

| 快捷键                  | 说明         |
|-------------------------|--------------|
| `tmux new -s <name>`    | 新建命名会话 |
| `Ctrl+b d`              | 分离会话     |
| `tmux ls`               | 列出会话     |
| `tmux attach -t <name>` | 重新连接     |

**窗格：**

| 快捷键           | 说明              |
|------------------|-------------------|
| `Ctrl+b %`       | 左右分屏          |
| `Ctrl+b "`       | 上下分屏          |
| `Ctrl+b <arrow>` | 切换窗格          |
| `Ctrl+b z`       | 当前窗格全屏/恢复 |
| `Ctrl+b x`       | 关闭窗格          |
| `Ctrl+b q`       | 显示窗格编号      |

**窗口：**

| 快捷键            | 说明              |
|-------------------|-------------------|
| `Ctrl+b c`        | 新建窗口          |
| `Ctrl+b p` / `n`  | 上一个/下一个窗口 |
| `Ctrl+b <number>` | 切换到指定窗口    |
| `Ctrl+b w`        | 从列表选择窗口    |
| `Ctrl+b ,`        | 窗口重命名        |
