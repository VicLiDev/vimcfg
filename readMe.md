# Vim 配置说明

## 仓库使用方法

建议创建软链接：
```bash
ln -s ${HOME}/Projects/vimcfg/mVimConfig ${HOME}/.vim
ln -s ${HOME}/Projects/vimcfg/mVimConfig/vimrc ${HOME}/.vimrc
ln -s ${HOME}/Projects/vimcfg/mVimConfig/gdbinit ${HOME}/.gdbinit
ln -s ${HOME}/Projects/vimcfg/mVimConfig/gdb_tools ${HOME}/.gdb
```

GDB 扩展工具安装：
```bash
# gef
git clone https://github.com/hugsy/gef.git ~/.gdb/gef
# peda
git clone https://github.com/longld/peda.git ~/.gdb/peda
# dashboard
wget https://github.com/cyrus-and/gdb-dashboard/raw/master/.gdbinit -O ~/.gdb/gdbdashboard
pip install pygments
# libheap
git clone https://github.com/cloudburst/libheap ~/.gdb/libheap
pip3 install --user ~/.gdb/libheap/
sudo apt-get install libc6-dbg
```

---


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
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --tag-relative=never
```

> `--tag-relative=never` 使用绝对路径，避免 `autochdir` 下标签跳转路径错误。

常用操作：

| 快捷键        | 说明                             |
|---------------|----------------------------------|
| `Ctrl+]`      | 跳转到函数/结构体定义            |
| `Ctrl+T`      | 返回                             |
| `gd`          | 跳转到局部变量定义（当前函数内） |
| `gD`          | 跳转到单词首次使用处             |
| `:ts`         | 列出匹配 tag                     |
| `:tn` / `:tp` | 下一个/上一个匹配 tag            |

**自定义类型高亮**：

Vim 默认只能高亮类型的声明处（`struct MyType { ... }`），无法在使用处（`MyType *ptr`）识别为类型。
配置通过 `after/syntax/c.vim` 在语法文件加载后从 tags 提取自定义类型名并高亮。

- 自动生效：打开 C/C++ 文件时自动从 tags 文件加载类型名
- 手动控制：`:CtagsHighlight` 刷新，`:CtagsHighlightClear` 清除
- 前提：需要 `ctags -R --tag-relative=never` 生成 tags 文件
- 仅高亮 C/C++ 源文件中的 `struct/union/enum/typedef/class` 类型

---

### clangd LSP

当安装了 clangd 后，自动通过 ALE 启用 LSP 语义分析，提供代码诊断和导航功能：
> 注意：clangd 在 Vim 中不提供语义着色（semanticTokens），该功能仅 Neovim 支持。

```bash
# 安装 clangd
sudo apt install clangd

# (可选) 生成 compile_commands.json 以获得准确的语义分析
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ...
# 或 Makefile 项目：
bear -- make
```

| 映射          | 说明          |
|---------------|---------------|
| `<leader>gd`  | 跳转到定义    |
| `<leader>k`   | 查看类型/文档 |
| `<leader>lr`  | 查找引用      |

自定义类型高亮与 clangd 职责不同，互不冲突，可同时工作：
- 自定义类型高亮负责**语法着色**，将自定义类型名以 Type 颜色高亮
- clangd 负责**代码智能**（诊断、跳转到定义、查看类型文档、查找引用）

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

> 已启用 `Gtags_Emacs_Like_Mode`，修复 `autochdir` 下 gtags 跳转路径错误。

---

### 配色

#### 双主题支持 (Gruvbox / TokyoNight)

支持在 gruvbox 和 tokyonight 之间无缝切换，每个主题拥有各自完整的语法/插件配色。

**使用方法：**

- 切换主题：`,th` 或 `:ToggleTheme`
- 默认主题：tokyonight（在 `commoncfg.vim` 中设置）

**工作原理：**

Vim 的 `after/colors/{name}.vim` 机制：当执行 `colorscheme xxx` 时，Vim 会自动加载对应的覆盖文件。
切换主题时，所有 `ColorScheme` autocmd 被触发，各插件配色自动适配。

切换流程：`:ToggleTheme` → `colorscheme` 触发 `ColorScheme` 事件 → `after/colors/{新主题}.vim` 
自动加载（语法高亮覆盖）→ `theme_custom.vim` 再次加载覆盖（防止插件覆盖回去）→ fzf/indentLine/illuminate/markdown
的 autocmd 各自更新插件配色。

**相关文件：**

| 文件                            | 作用                                                                    |
|---------------------------------|-------------------------------------------------------------------------|
| `after/colors/gruvbox.vim`      | Gruvbox 语法高亮覆盖（`hi! link` 到 Gruvbox* 组）                       |
| `after/colors/tokyonight.vim`   | TokyoNight 语法高亮覆盖（直接 `hi!` 写死色值）                          |
| `after/plugin/theme_custom.vim` | 加载器：监听 `ColorScheme` 事件，启动时检测主题并应用覆盖               |
| `vimrcs/plugins.vim`            | fzf/indentLine/illuminate/markdown 配色改为函数 + `ColorScheme` autocmd |
| `vimrcs/commoncfg.vim`          | `:ToggleTheme` 命令定义和 `<Leader>th` 快捷键                           |

**色值映射（Gruvbox → TokyoNight）：**

| 角色   | Gruvbox 组       | TokyoNight 色值              |
|--------|------------------|------------------------------|
| Red    | `GruvboxRed`     | `#F7768E`, cterm=203         |
| Orange | `GruvboxOrange`  | `#FF9E64`, cterm=215         |
| Yellow | `GruvboxYellow`  | `#E0AF68`, cterm=179         |
| Green  | `GruvboxGreen`   | `#9ECE6A`, cterm=107         |
| Aqua   | `GruvboxAqua`    | `#7DCFFF`, cterm=117         |
| Blue   | `GruvboxBlue`    | `#7AA2F7`, cterm=110         |
| Purple | `GruvboxPurple`  | `#BB9AF7`, cterm=180         |
| Fg1    | `GruvboxFg1`     | `#a9b1d6`, cterm=250         |
| Fg2    | `GruvboxFg2`     | `#9aa5ce`, cterm=248         |
| Fg3    | `GruvboxFg3`     | `#7982a9`, cterm=247         |
| Fg4    | `GruvboxFg4`     | `#565f89`, cterm=240         |
| Gray   | `GruvboxGray`    | `#444B6A`, cterm=60          |
| Bold   | `GruvboxXxxBold` | 同色 + `gui=bold cterm=bold` |

> TokyoNight 未定义 `Gruvbox*` 组，因此 `after/colors/tokyonight.vim` 使用直接 `hi!` 而非 `hi! link`。

**插件配色适配：**

- **fzf**：匹配高亮 `hl` 在 gruvbox 下用 `GruvboxYellow`，tokyonight 下用 `Number`
- **indentLine**：背景色 gruvbox `#3c3836` / tokyonight `#24283b`
- **illuminate**：高亮底色 gruvbox 暖橙 `#3d2a28` / tokyonight 冷蓝 `#2d2f45`
- **vim-markdown**：标题渐变（橙→黄→绿→青→蓝→紫）各自使用对应主题的调色板

两个 `after/colors/` 文件覆盖完全相同的 89 个高亮组，涵盖：通用语法、Vim、Shell、C/C++、Python、
JavaScript、PanglossJS、Markdown、NERDTree。

#### 其他推荐配色

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







## GDB

GDB（GNU Debugger）提供了很多方式来定制和扩展其功能，包括通过脚本、插件以及命令
扩展。常见的扩展方式有三种：
* 通过 GDB 内置的脚本语言（Python）
* GDB 插件（C/C++ 扩展）
* GDB 的命令

下面是一些常见的编写 GDB 工具的方法。

### 使用 GDB 的 Python 脚本扩展

GDB 支持 Python 脚本来编写自定义工具和扩展。你可以通过 Python 脚本访问 GDB 的调试
功能，甚至实现复杂的调试逻辑。

#### 步骤：
1. **确保 GDB 支持 Python**：大部分现代版本的 GDB 都内置了 Python 支持。可以通过
   命令 `gdb --version` 来检查当前版本是否支持 Python。
2. **编写 Python 脚本**：
   - 你可以直接在 GDB 中输入 Python 脚本：
     ```bash
     (gdb) python
     >>> import gdb
     >>> print(gdb.selected_frame())
     >>> gdb.execute('info locals')
     >>> print(gdb.parse_and_eval('$eax'))
     >>> exit()
     ```

   - 也可以将 Python 脚本保存为文件，并通过 `source` 命令加载：
     ```python
     # example.py
     import gdb

     class MyCommand(gdb.Command):
         def __init__(self):
             super(MyCommand, self).__init__("mycommand", gdb.COMMAND_DATA)

         def invoke(self, arg, from_tty):
             print("Hello from custom command!")
             gdb.execute("info registers")

     MyCommand()
     ```

   在 GDB 中加载：
   ```bash
   (gdb) source example.py
   ```

#### Python 脚本常用功能：
- 获取当前堆栈帧：`gdb.selected_frame()`
- 获取寄存器值：`gdb.parse_and_eval('$eax')`
- 执行 GDB 命令：`gdb.execute('command')`
- 定义自定义命令：通过继承 `gdb.Command` 类实现

#### Python脚本详细教程

##### 确保 GDB 支持 Python
首先，确认你使用的 GDB 版本支持 Python。在终端输入以下命令检查：
```bash
gdb --version
```
输出中应该包含类似 `Python` 的字样，表示 GDB 编译时启用了 Python 支持。

##### 在 GDB 中使用 Python

GDB 提供了一个 Python 解释器环境，可以直接在 GDB 中输入 Python 代码进行调试和扩展。

可以在 GDB 提示符下直接输入 Python 代码。例如：
```bash
(gdb) python print("Hello, GDB from Python!")
```

此外，还可以在 GDB 中运行更复杂的 Python 代码：
```bash
(gdb) python
>>> import gdb
>>> frame = gdb.selected_frame()
>>> print(frame.name())
>>> register = gdb.parse_and_eval("$eax")
>>> print(register)
>>> exit()
```

##### 编写 Python 脚本

可以将 Python 代码保存到脚本文件中，方便重用和管理。GDB 支持通过 `source` 命令
加载 Python 脚本。

在 GDB 中，脚本的文件名 不需要与自定义命令的名称一致。一个 Python 脚本中可以定义
多个自定义命令，它们完全可以使用不同的命令名。

###### 示例：创建一个简单的 Python 脚本

假设想创建一个 Python 脚本，该脚本能够打印出当前的寄存器值和栈信息。

```python
# file: dump_registers.py

import gdb

class DumpRegistersCommand(gdb.Command):
    """A custom GDB command to dump register values."""

    def __init__(self):
        super(DumpRegistersCommand, self).__init__("dump_registers", gdb.COMMAND_DATA)

    def invoke(self, arg, from_tty):
        frame = gdb.selected_frame()  # 获取当前堆栈帧
        print("Register values:")
        # 获取并打印当前堆栈帧中的所有寄存器值
        for reg in gdb.selected_inferior().architecture().registers():
            reg_value = frame.read_register(reg)
            print(f"{reg.name}: {reg_value}")
        print("End of register dump")

# Register the command
DumpRegistersCommand()
```

###### 说明：
- 我们定义了一个新的 GDB 命令 `dump_registers`，它将输出当前所有的寄存器值和堆栈跟踪信息。
- 使用 `gdb.selected_frame()` 获取当前堆栈帧，并使用 `frame.read_register()` 获取寄存器的值。
- 使用 `gdb.execute("backtrace")` 执行 GDB 的内置命令 `backtrace`，以打印堆栈信息。

###### 在 GDB 中加载 Python 脚本
1. 将上面的 Python 代码保存为文件，例如 `dump_registers.py`。
2. 在 GDB 中，使用 `source` 命令加载脚本：
```bash
(gdb) source dump_registers.py
```
3. 运行自定义命令：
```bash
(gdb) dump_registers
```

这时，`dump_registers` 命令会执行，并输出当前的寄存器值和堆栈信息。

##### Python 与 GDB 内部数据结构交互
GDB 提供了非常丰富的 Python API，可以与调试器的各个部分进行交互。以下是一些常见的操作：

###### 获取当前堆栈帧
你可以通过 Python 脚本访问当前的堆栈帧和局部变量：
```python
frame = gdb.selected_frame()
print(frame.name())  # 打印当前函数名
for var in frame.block():
    print(var.name, var.value())  # 打印当前堆栈帧中的所有局部变量
```

###### 获取和设置寄存器值
你可以通过 Python 获取或设置寄存器的值：
```python
# 获取寄存器的值
eax_value = gdb.parse_and_eval('$eax')
print(f'EAX: {eax_value}')

# 设置寄存器的值
gdb.execute('set $eax = 0x12345678')
```

###### 获取和设置内存
你可以直接访问目标程序的内存，进行读写操作：
```python
# 读取内存
address = 0x601000
data = gdb.selected_inferior().read_memory(address, 4)
print(data)

# 写入内存
gdb.selected_inferior().write_memory(address, b'\x90\x90\x90\x90')  # 写入 NOP 指令
```

###### 调试控制

你可以通过 Python 脚本控制 GDB 调试过程，例如设置断点、步进、继续执行等：
```python
# 设置断点
gdb.execute('break main')

# 继续执行程序
gdb.execute('continue')

# 步进执行
gdb.execute('step')
```

##### 创建交互式的 GDB 命令
你还可以创建交互式的命令，允许用户输入参数并在命令执行时进行处理。

###### 示例：带参数的自定义命令
```python
# file: set_breakpoint.py

import gdb

class SetBreakpointCommand(gdb.Command):
    """A custom GDB command to set a breakpoint at a specific function."""

    def __init__(self):
        super(SetBreakpointCommand, self).__init__("set_breakpoint", gdb.COMMAND_BREAKPOINTS)

    def invoke(self, arg, from_tty):
        # 检查传入的参数，期望传入一个函数名
        if not arg:
            print("Usage: set_breakpoint <function_name>")
            return
        # 设置断点
        gdb.execute(f"break {arg}")
        print(f"Breakpoint set at function: {arg}")

# Register the command
SetBreakpointCommand()
```

保存为 `set_breakpoint.py`，然后加载到 GDB 中：
```bash
(gdb) source set_breakpoint.py
```

然后使用自定义命令设置断点：
```bash
(gdb) set_breakpoint main
```

##### 调试脚本的调试和优化

当编写 Python 脚本来扩展 GDB 时，调试脚本本身也是很重要的。你可以使用标准的 Python
调试工具（如 `pdb`）来调试脚本的逻辑，或者在 GDB 中设置调试输出：
```python
# 添加调试输出
print("Debugging the script...")
```

在 GDB 中使用 `set debug` 命令来增加调试信息：
```bash
(gdb) set debug python on
```

##### 常用的 GDB Python API
- `gdb.selected_frame()`：获取当前堆栈帧。
- `gdb.selected_inferior()`：获取当前调试目标。
- `gdb.parse_and_eval(expression)`：解析并计算表达式。
- `gdb.execute(command)`：执行 GDB 命令。
- `gdb.regs()`：获取当前可用的寄存器列表。
- `gdb.breakpoint(function_name)`：设置一个函数的断点。

##### 保存和加载脚本
- **保存脚本**：将 Python 脚本保存为 `.py` 文件，方便日后使用。
- **加载脚本**：通过 `source` 命令加载 Python 脚本：
```bash
(gdb) source my_script.py
```

- **自动加载脚本**：你可以将脚本添加到 GDB 的启动配置文件 `.gdbinit` 中，自动加载：
```bash
# ~/.gdbinit
source /path/to/my_script.py
```

### 编写 GDB 插件（C/C++ 扩展）

除了使用 Python 脚本，GDB 还允许使用 C/C++ 编写插件，以实现更高效、更复杂的功能。

#### 步骤：
1. **了解 GDB 插件机制**：GDB 插件是由 C/C++ 编写的动态链接库，它们通过 GDB 的
   `-ex` 或 `-command` 选项加载。插件通过 C++ 的 GDB API 与 GDB 交互。
2. **编写插件代码**：
   插件的基本框架：
   ```cpp
   #include <gdb/gdb.h>
   #include <gdb/common/common.h>

   extern "C" void
   _initialize_my_plugin(void)
   {
       // 在这里定义你的 GDB 扩展命令
   }
   ```

3. **编译插件**：将插件编译为共享库（.so 文件）：
   ```bash
   g++ -shared -fPIC -o my_plugin.so my_plugin.cpp -lgdb
   ```

4. **加载插件**：在 GDB 中加载插件：
   ```bash
   (gdb) set auto-load safe-path /path/to/plugin
   (gdb) source /path/to/my_plugin.so
   ```

#### 插件常用功能：
- 通过 C/C++ 代码访问 GDB 的内部 API，如操作断点、堆栈、寄存器、内存等。
- 注册自定义的 GDB 命令。
- 实现复杂的调试功能，比如自动化检查、动态分析等。

### 使用 GDB 自定义命令和宏

你可以在 GDB 中定义自己的命令和宏，来自动化调试过程。

#### 定义 GDB 命令：
- 在 GDB 中，你可以定义一个新的命令（类似内建命令）：
  ```bash
  (gdb) define my_command
  Type commands for definition of "my_command".
  End with a line saying just "end".
  > info locals
  > info registers
  > end
  ```
- 每次调用 `my_command` 时，它会自动执行 `info locals` 和 `info registers` 命令。

#### 定义 GDB 宏：
- GDB 也支持在 `.gdbinit` 文件中定义宏：
  ```bash
  define my_macro
  echo "Start of custom command\n"
  info locals
  info registers
  end
  ```

  然后在 GDB 中运行：
  ```bash
  (gdb) my_macro
  ```

### 使用 GDB 的 TUI 模式
如果你需要开发一个具有图形界面的调试工具，可以使用 GDB 的 TUI（Text User Interface）
模式。通过 TUI 模式，你可以创建分屏的界面，显示源代码、寄存器、堆栈等信息。

#### 启用 TUI 模式：
```bash
(gdb) tui enable
```
这会将 GDB 的界面切换为分屏模式，可以通过快捷键控制不同的视图。

### 其他调试功能扩展

- **自定义断点处理**：你可以为断点设置条件、命令或日志输出。例如：
  ```bash
  (gdb) break main if x == 42
  (gdb) break foo do printf("foo hit\n")
  ```

- **脚本化调试流程**：通过脚本自动化一些重复性操作，如在程序崩溃时自动收集堆栈
  跟踪信息、输出变量的值等。

### 总结：

编写自己的 GDB 工具可以通过多种方式实现，Python 脚本是最常见和简单的方式，可以
快速实现自定义命令和调试逻辑；而 C/C++ 插件则适用于需要更高性能或更复杂功能的
场景。通过自定义命令和宏，GDB 也能实现一定程度的自动化调试。如果你对 GDB 的内核
和扩展机制有深入了解，还可以编写更为复杂的插件来满足你的需求。

---

## Vim Tutorials

### Common settings

- vim中set设置的是选项，let设置的是变量。let g: 这里的g是全局的意思
- let后字母的含义：(参阅：命令行模式执行help internal-variables)
- buffer-variable b：当前缓冲区本地。
- window-variable w：当前窗口本地。
- tabpage-variable t：位于当前标签页的本地。
- global-variable ：全局。
- local-variable l：函数本地。
- script-variable s：对于：source的Vim脚本来说是本地的。
- function-argument a：函数参数（仅在函数内部）。
- vim-variable v：全局，由Vim预定义。

### autocmd

自动命令，是在指定事件发生时自动执行的命令，比如自定义以下函数，用于在文件中插入当前日期：

```vim
function DateInsert()
    $read !date
endfunction
```

使用以下命令，可以手动调用此函数：
```vim
call DateInsert()
```

而通过以下自动命令，则可以在保存文件时自动执行函数，而不再需要额外的手动操作：
```vim
autocmd FileWritePre * :call DateInsert()<CR>
```

可以使用以下格式的autocmd命令，来定义自动命令：
- autocmd [group] events pattern [nested] command
- group，组名是可选项，用于分组管理多条自动命令；
- events，事件参数，用于指明触发命令的一个或多个事件；
- pattern，限定针对符合匹配模式的文件执行命令；
- nested，嵌套标记是可选项，用于允许嵌套自动命令；
- command，指明需要执行的命令、函数或脚本。

以下是一些 Vim 中常用的 autocmd 事件：

| 事件           | 说明 |
|----------------|----------------------------------------------------------|
| `BufEnter`     | 当进入缓冲区时触发                                       |
| `BufLeave`     | 当离开缓冲区时触发，可执行清理工作                       |
| `BufNewFile`   | 当创建新文件时触发，可设置默认格式或内容                 |
| `BufRead`      | 当读取缓冲区时触发（通常在打开文件时）                   |
| `BufReadPost`  | 在 BufRead 之后触发，文件完全加载后执行命令              |
| `BufWrite`     | 在写入缓冲区到文件之前触发，可执行检查或修改             |
| `BufWritePost` | 在写入缓冲区到文件之后触发，可更新其他文件或触发外部程序 |
| `CursorHold`   | 当光标停止移动一定时间后触发                             |
| `CursorHoldI`  | 与 CursorHold 类似，但仅在插入模式下触发                 |
| `FileType`     | 当文件类型被设置时触发，可为不同类型文件设置不同配置     |
| `InsertEnter`  | 当进入插入模式时触发                                     |
| `InsertLeave`  | 当离开插入模式时触发                                     |
| `VimEnter`     | Vim 启动并读取 .vimrc 文件后触发                         |
| `VimLeave`     | Vim 退出前触发                                           |
| `VimLeavePre`  | 在 VimLeave 之前触发                                     |
| `WinEnter`     | 当进入窗口时触发                                         |
| `WinLeave`     | 当离开窗口时触发                                         |

使用以下命令，可以列出所有自动命令：
```vim
:autocmd
```

### key map

参考：https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)

#### 模式介绍

- **Normal Mode**：普通模式，默认进入vim之后处于这种模式。
- **Visual Mode**：可视模式，选定字符、行、多列。普通模式下按 `v` 进入。
- **Insert Mode**：插入模式，编辑输入状态。普通模式下按 `i` 进入。
- **Select Mode**：选择模式，用鼠标拖选区域时进入，敲任何按键直接替换选中文本。
- **Command-Line/Ex Mode**：命令行模式，普通模式下按 `:` 进入。

#### 映射语法

```
{cmd} {attr} {lhs} {rhs}

where
{cmd}  is one of ':map', ':map!', ':nmap', ':vmap', ':imap',
       ':cmap', ':smap', ':xmap', ':omap', ':lmap', etc.
{attr} is optional and one or more of the following: <buffer>, <silent>,
       <expr> <script>, <unique> and <special>.
{lhs}  left hand side, is a sequence of one or more keys that you will use
       in your new shortcut.
{rhs}  right hand side, is the sequence of keys that the {lhs} shortcut keys
       will execute when entered.
```

#### 创建映射

创建映射的步骤：
1. 确定映射将要运行的键的顺序
2. 确定映射应在其中工作的编辑模式
3. 找到可用于调用映射的未使用键序列

#### 显示映射

| 命令    | 说明                                                   |
|---------|--------------------------------------------------------|
| `:map`  | 显示普通模式、可视模式、选择模式、操作员待定模式的映射 |
| `:map!` | 显示插入模式、命令行模式的映射                         |
| `:nmap` | 显示普通模式映射                                       |
| `:imap` | 显示插入模式映射                                       |
| `:vmap` | 显示可视、选择模式映射                                 |
| `:smap` | 显示选择模式映射                                       |
| `:xmap` | 显示可视模式映射                                       |
| `:cmap` | 显示命令行模式映射                                     |
| `:omap` | 显示操作员待定模式映射                                 |

#### 删除映射

使用 `:verbose map {lhs}` 定位映射定义位置，然后编辑对应文件。或直接使用 unmap 命令：

| 命令     | 说明                                  |
|----------|---------------------------------------|
| `nunmap` | Unmap a normal mode map               |
| `vunmap` | Unmap a visual and select mode map    |
| `xunmap` | Unmap a visual mode map               |
| `sunmap` | Unmap a select mode map               |
| `iunmap` | Unmap an insert and replace mode map  |
| `cunmap` | Unmap a command-line mode map         |
| `ounmap` | Unmap an operator pending mode map    |

清除特定模式下的所有映射：`mapclear`、`nmapclear`、`imapclear` 等。

#### 模式特定的映射命令

| Commands                     | Mode                    |
|------------------------------|-------------------------|
| `nmap`, `nnoremap`, `nunmap` | Normal mode             |
| `imap`, `inoremap`, `iunmap` | Insert and Replace mode |
| `vmap`, `vnoremap`, `vunmap` | Visual and Select mode  |
| `xmap`, `xnoremap`, `xunmap` | Visual mode             |
| `smap`, `snoremap`, `sunmap` | Select mode             |
| `cmap`, `cnoremap`, `cunmap` | Command-line mode       |
| `omap`, `onoremap`, `ounmap` | Operator pending mode   |

#### 鼠标事件映射

```
<LeftMouse>     - Left mouse button press
<RightMouse>    - Right mouse button press
<MiddleMouse>   - Middle mouse button press
<LeftRelease>   - Left mouse button release
<RightRelease>  - Right mouse button release
<MiddleRelease> - Middle mouse button release
<LeftDrag>      - Mouse drag while Left mouse button is pressed
<RightDrag>     - Mouse drag while Right mouse button is pressed
<MiddleDrag>    - Mouse drag while Middle mouse button is pressed
<2-LeftMouse>   - Left mouse button double-click
<2-RightMouse>  - Right mouse button double-click
<3-LeftMouse>   - Left mouse button triple-click
<3-RightMouse>  - Right mouse button triple-click
<4-LeftMouse>   - Left mouse button quadruple-click
<4-RightMouse>  - Right mouse button quadruple-click
<X1Mouse>       - X1 button press
<X2Mouse>       - X2 button press
<X1Release>     - X1 button release
<X2Release>     - X2 button release
<X1Drag>        - Mouse drag while X1 button is pressed
<X2Drag>        - Mouse drag while X2 button is pressed

example: :nnoremap <2-LeftMouse> :exe "tag ". expand("<cword>")<CR>
```

---

### Custom function (vimscript)

参考：https://www.ibm.com/developerworks/cn/linux/l-vim-script-2/index.html

Vimscript 中的函数使用 function 关键字定义，后跟函数名，然后是参数列表（这是强制的，即使该函数没有参数）。
函数体从下一行开始，直到遇到 endfunction 关键字。

#### 基本语法

1. 函数返回值使用 return 语句指定。函数被用作过程时可不包含 return 语句，Vimscript 函数始终返回一个值，
   未指定 return 则自动返回 0。
2. Vimscript 中的函数名必须以大写字母开头。
3. 可以使用显式的范围前缀声明函数，最常见的是 `s:`（脚本局部）：
   ```vim
   function s:save_backup()
     let b:backup_count = exists('b:backup_count') ? b:backup_count+1 : 1
     return writefile(getline(1,'$'), bufname('%') . '_' . b:backup_count)
   endfunction
   nmap <silent> <C-B> :call s:save_backup()<CR>
   ```
4. 使用 `function!` 允许安全重载函数（避免重复声明冲突）：
   ```vim
   function! s:save_backup()
     " ...
   endfunction
   ```

#### 调用函数

- 使用返回值：`let success = setline('.', ExpurgateText(getline('.')))`
- 忽略返回值（作为过程调用）：必须使用 `call` 前缀：`call SaveBackup()`

#### 参数列表

1. **命名参数**（最多 20 个），通过 `a:` 前缀访问：
   ```vim
   function PrintDetails(name, title, email)
     echo 'Name:   ' a:title a:name
     echo 'Contact:' a:email
   endfunction
   ```

2. **可变参数**（使用 `...`），通过 `a:000`（数组）和 `a:0`（数量）访问：
   ```vim
   function Average(...)
       let sum = 0.0
       for nextval in a:000
           let sum += nextval
       endfor
       return sum / a:0
   endfunction
   ```
   注意：sum 必须初始化为显式浮点值，否则使用整数运算。

3. 可同时使用命名参数和可变参数，省略号放在命名参数之后。

---

### Custom command (`command!`)

#### `function!` 和 `command!` 的区别

| 特性         | `function!` (函数)           | `command!` (自定义命令)              |
|--------------|------------------------------|--------------------------------------|
| **用途**     | 定义可复用的 Vimscript 函数  | 定义可在命令行模式 (`:`) 调用的命令  |
| **调用方式** | `:call MyFunc()`             | `:MyCommand`                         |
| **作用域**   | 可指定 `s:`、`g:` 等         | 默认全局可用                         |
| **参数处理** | 通过 `a:1`, `a:2` 访问       | 通过 `<args>`, `<f-args>` 等特殊标记 |
| **覆盖行为** | `function!` 允许覆盖同名函数 | `command!` 允许覆盖同名命令          |
| **适用场景** | 复杂逻辑、代码复用           | 快速封装常用操作                     |

#### `command!` 语法

```vim
command! [options] {cmd_name} {cmd_body}
```

常用选项：

| 选项         | 说明                                                                    |
|--------------|-------------------------------------------------------------------------|
| `-bang`      | 允许命令后加 `!`（如 `:MyCommand!`），通过 `<bang>` 访问                |
| `-nargs=`    | 参数数量：`0`（无）、`1`（1个）、`*`（任意）、`?`（0或1）、`+`（至少1） |
| `-complete=` | 启用参数补全（如 `-complete=file`）                                     |
| `-range`     | 允许行范围，通过 `<line1>`, `<line2>` 访问                              |
| `-bar`       | 允许命令后跟 `\|` 执行其他命令                                          |

参数标记：

| 标记                 | 说明                            |
|----------------------|---------------------------------|
| `<args>`             | 所有参数（字符串）              |
| `<f-args>`           | 参数列表（适合传给函数）        |
| `<bang>`             | 命令带 `!` 时为 `"!"`，否则为空 |
| `<line1>`, `<line2>` | 行范围（配合 `-range`）         |
| `<q-args>`           | 引号包裹的参数（避免空格拆分）  |

#### 示例

(1) 无参数命令：
```vim
command! Hello echo "Hello, Vim!"
" :Hello  → 输出 Hello, Vim!
```

(2) 带 `!` 和参数：
```vim
command! -bang -nargs=* SayHi echo "Hi," <q-args> . (<bang> == "!" ? "!" : ".")
" :SayHi World   → Hi, World.
" :SayHi! World  → Hi, World!
```

(3) 调用函数：
```vim
function! Greet(name) abort
  echo "Hello, " . a:name
endfunction
command! -nargs=1 Greet call Greet(<f-args>)
" :Greet Alice  → Hello, Alice
```

(4) 带行范围：
```vim
command! -range=% ShowLines echo "Lines: " . <line1> . "-" . <line2>
" :10,20ShowLines  → Lines: 10-20
```

---

## 参考教程

- [简明 VIM 练级攻略](https://coolshell.cn/articles/5426.html)
- [vim操作全面讲解](http://www.cnblogs.com/hustskyking/archive/2013/06/11/linux-learning-details.html)
- [Vim 的纵向编辑模式](https://www.ibm.com/developerworks/cn/linux/l-cn-vimcolumn/index.html)
