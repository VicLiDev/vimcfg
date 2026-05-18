# mVimConfig 当前结构文档

> 更新时间: 2026-05-18
> 基于 patch-1 (c9b9a46) 重构后的最终状态

---

## 目录结构

```
mVimConfig/
├── vimrc                          # Vim 入口文件（source 各模块）
├── vimrcs/
│   ├── plugin_manager.vim         # [symlink → pm_vimplug.vim] 插件管理器入口
│   ├── pm_vimplug.vim             # vim-plug 管理器配置
│   ├── pm_vundle.vim              # Vundle 管理器配置（备用）
│   ├── plugins_list.vim           # 插件列表（两管理器共享）
│   ├── plugins.vim                # 插件配置入口：source plugins/*.vim
│   ├── plugins/                   # 按功能域分类的插件配置
│   │   ├── ui.vim                 #   startify, airline, nerdtree, devicons, illuminate, lastplace
│   │   ├── search.vim             #   ctrlp, fzf, ack/ag/grep, tagbar, gtags
│   │   ├── git.vim                #   fugitive, gitgutter, blame
│   │   ├── code.vim               #   YCM, ALE, ctags, surround, camelcasemotion, smartrename
│   │   ├── snippet.vim            #   ultisnips, yankstack, peekaboo
│   │   ├── lang.vim               #   vimtex, markdown, plantuml, json, yaml
│   │   ├── misc.vim               #   oscyank, easymotion, tabular, commentary, mark
│   │   └── gtags.vim              #   gtags 详细配置（独立大文件）
│   ├── commoncfg.vim              # [DEPRECATED] 旧版单文件配置，已拆分，不再加载
│   ├── 01_basic.vim               # 基本编辑器选项
│   ├── 02_theme.vim               # 主题配色 & ToggleTheme
│   ├── 03_format_build.vim        # 格式化工具 & 行尾空格清理
│   ├── 04_mappings.vim            # 键位映射
│   ├── 05_autocmds.vim            # 自动命令（统一管理）
│   ├── 06_functions.vim           # 自定义函数
│   └── fzf/                       # FZF 额外配置
└── docs/
    └── current-structure.md       # 本文档
```

---

## 加载顺序

```
vimrc
  └─ source vimrcs/plugin_manager.vim (pm_vimplug.vim)
       ├─ plug#begin / plug#end
       ├─ source plugins_list.vim     (插件安装)
       └─ filetype plugin indent on   (文件类型检测)

  └─ source vimrcs/plugins.vim
       └─ for 循环 source plugins/{ui,search,git,code,snippet,lang,misc}.vim

  └─ source vimrcs/01_basic.vim       (基本选项: 兼容性/剪贴板/搜索/编码/缩进/折叠/鼠标...)
  └─ source vimrcs/02_theme.vim       (主题切换 ToggleTheme, 高亮组)
  └─ source vimrcs/03_format_build.vim(格式化: CleanExtraSpaces, astyle)
  └─ source vimrcs/04_mappings.vim    (键映射: F5/F6/F12/窗口/buffer/tab/leader)
  └─ source vimrcs/05_autocmds.vim    (autocmd 组: filetype/cursorline/cleanup/template/gitblame/fold)
  └─ source vimrcs/06_functions.vim   (函数: CompileRunGcc/Dbg, SetTitle, SwitchTab, InsertLog, Git工具)
```

---

## 各文件详细说明

### 01_basic.vim — 基本编辑器选项 (487行)

| 分类 | 关键设置 |
|------|----------|
| 兼容性 | `set nocompatible` |
| 剪贴板 | `set clipboard=unnamedplus` (Linux/Mac 自动判断) |
| 搜索 | `ignorecase`, `smartcase`, `hlsearch`, `incsearch` |
| 编辑行为 | `backspace=indent,eol,start`, `scrolloff=5`, `sidescrolloff=15` |
| 显示 | `number`, `cursorline`, `colorcolumn=80,100`, `ruler`, `showmatch` |
| 编码 | `encoding=utf-8`, `fileencoding=utf-8`, `fileencodings=ucs-bom,utf-8,cp936,...` |
| 缩进 | `tabstop=4`, `shiftwidth=4`, `expandtab`, `softtabstop=4`, `autoindent`, `cindent`, `smartindent` |
| 折叠 | `foldmethod=marker`, `foldcolumn=2` |
| 鼠标 | `set mouse=a` |
| 文件操作 | `autoread`, `confirm`, `autowrite`, `undofile` (~/.vim_runtime/temp_dirs/undodir) |
| 正则 | `set magic` |

**注意**: filetype 相关设置不在此文件，由 plugin_manager.vim 统一处理。

---

### 02_theme.vim — 主题配色 (31行)

| 功能 | 说明 |
|------|------|
| `ToggleTheme` | gruvbox ↔ tokyonight 切换 (`<Leader>th`) |
| 状态行 | 备注引用（实际在 01_basic.vim 设置） |
| 高亮组 | `hi Normal ctermbg=none` (透明背景) |
| cursorline | InsertLeave/InsertEnter 自动切换 |

---

### 03_format_build.vim — 格式化与构建 (20行)

| 函数/命令 | 说明 |
|-----------|------|
| `CleanExtraSpaces()` | 保存时清理行尾空格（保存/恢复光标+搜索寄存器） |
| `BufWritePre *` | 全文件类型触发 CleanExtraSpaces |
| `FormatCode` | astyle 代码格式化命令 |
| `BufWritePre *.c,*.cpp` | C/C++ 文件自动 astyle 格式化 |

**注意**: 05_autocmds.vim 中有另一份 BufWritePre 调用 CleanExtraSpaces，限定为代码文件类型。两者并存，03 版本范围更广。

---

### 04_mappings.vim — 键位映射 (117行)

| 按键 | 功能 | 模式 |
|------|------|------|
| `,w` | 保存 | n |
| `,f` | find 查找文件 | n |
| `0` | 跳到行首非空白字符 | n (覆盖默认) |
| `Ctrl+h/j/k/l` | 窗口切换 | n |
| `,q` | 关闭窗口 | n |
| `Alt+j/k` | 上下移动当前行/选中行 | n/v |
| `,h` | 取消搜索高亮 | n |
| `,sh` | 进入 shell | n |
| `,bn/bb/bs/bf/bl/bc` | buffer 切换/删除 | n |
| `,tN/tn/tp/tc/to/te` | 标签页管理 | n |
| `,tl` | 上次访问 tab 快速切换 | n |
| `Ctrl+A/E/K/P/N` | Bash 风格命令行快捷键 | c |
| `Ctrl+A` | 全选+复制 | n/i |
| `Ctrl+c` | 选中内容复制到系统剪贴板 | v |
| `F2` | 删除空行 (会被 SmartRename 覆盖) | n |
| `Ctrl+F2` | 纵向 diff 对比 | n |
| `Alt+F2` | 新建标签页 | n |
| `F3` | 当前目录文件列表 (tabnew .) | n |
| `Ctrl+F3` | 打开 NERDTree | n |
| **F5** | **编译运行 (CompileRunGcc)** | n |
| **F6** | **GDB 调试 (CompileRunDbg)** | n |
| **F12** | **Tab/Space 切换 (SwitchTab)** | n |
| `,ll` | 插入 printf 日志 | n |

**mapleader = `,`**

---

### 05_autocmds.vim — 自动命令 (49行)

所有 autocmd 按功能分组在 augroup 中管理：

| augroup | 触发事件 | 功能 |
|---------|----------|------|
| `vimcfg_filetype` | BufRead,BufNewFile | Linux 下 txt 文件类型高亮 |
| `vimcfg_cursorline` | InsertLeave,InsertEnter | cursorline 自动开关 |
| `vimcfg_cleanup` | BufWritePre (*.c,*.cpp,*.h,*.hpp,*.sh,*.py,*.java,*.vim) | 清理行尾空格; C/C++ F9 make 映射 |
| `vimcfg_tabtrack` | TabLeave | 记录最后访问 tab 编号 |
| `vimcfg_template` | BufNewFile (*.cpp,*.hpp,*.[ch],*.sh,*.py,*.java) | 调用 SetTitle() 插入文件头; 定位到文件末尾 |
| `vimcfg_gitblame` | CursorHold | 自动关闭 git blame 视图 |
| `vimcfg_fold` | FileType markdown | 展开所有折叠 (foldlevel=99) |

---

### 06_functions.vim — 自定义函数 (283行)

#### 工具函数

| 函数 | 签名 | 用途 |
|------|------|------|
| `CleanExtraSpaces()` | 无参 | 行尾空格清理（含搜索寄存器保护） |
| `IsFileExists(fname)` | 单参数 | `filereadable()` 封装 |
| `IsInGitRepo()` | 无参 | `git rev-parse --is-inside-work-tree` + v:shell_error 判断 |
| `CheckGitRootFile(root, file)` | 双参数 | 检查 git root 下是否存在指定文件（支持目录和普通文件） |
| `ExecGitRootTool(cmd, root)` | 双参数 | 在 git root 目录执行外部命令 (`!cd root && cmd`) |

#### 编译运行 F5 — CompileRunGcc()

优先级从高到低：

1. **当前目录构建脚本** — `.prjBuild.sh` > `prjBuild.sh`
2. **Git root 构建脚本** — `.prjBuild.sh` > `prjBuild.sh` (通过 ExecGitRootTool)
3. **项目构建系统** — CMakeLists.txt → `cmake .. && make`; Makefile → `make`; meson.build → `ninja`
4. **单文件编译运行**（按 filetype）:

| 语言 | 编译命令 | 运行命令 | 特殊标志 |
|------|----------|----------|----------|
| c | `gcc -Wall -Wextra % -o %<` | `time ./%<` | silent exec (编译不暂停) |
| cpp | `g++ -std=c++11 -Wall -Wextra % -o %<` | `time ./%<` | 同上 |
| java | `javac %` | `time java %<` | |
| sh | — | `time bash %` | 仅运行 |
| python | — | `time python3 %` | 仅运行 |
| html | — | `google-chrome % &` | 后台运行 |
| go | `go build -o %< %` | `time ./%<` | |
| mksh | — | `time mksh %` | |
| lua | — | `time lua5.4 %` | |
| rust | `rustc % -o %<` | `time ./%<` | |
| typescript | — | `tsc % && node %<` | 编译+运行链式 |
| javascript | — | `node %` | 仅运行 |

**执行方式**: `silent exec compilecmd` (编译不暂停) + `exec excmd` (运行完暂停等回车)

#### GDB 调试 F6 — CompileRunDbg()

同样的三级优先级结构（prjDebug.sh → git root prjDebug.sh → 单文件调试）:

| 语言 | 调试命令 |
|------|----------|
| c (Linux) | `gcc -g -o %< -Wall -Wextra && gdb --command=debug.gdb ./%<` |
| c (Mac) | `gcc -g ... && lldb ./%<` |
| cpp (Linux) | `g++ -g ... && gdb --command=debug.gdb ./%<` |
| cpp (Mac) | `g++ -g ... && lldb ./%<` |
| python | `python3 -m pdb %` |
| sh | `bash -x %` |
| go | `dlv debug %` |
| rust | `rust-gdb %<` |

#### Tab/Space 切换 F12 — SwitchTab()

- Tab 模式: `noexpandtab`, `textwidth=80`
- Space 模式: `expandtab`, `textwidth=0`, tab=4 空格

#### 新建文件模板 — SetTitle()

按 filetype 自动插入文件头:

| 类型 | shebang/注释风格 | 额外内容 |
|------|------------------|----------|
| sh | `#!/usr/bin/env bash` | `#` 注释块 (File/Author/Mail/Created Time) |
| python | `#!/usr/bin/env python` | 同上 |
| cpp | `/* ... */` C 风格 | `#include <iostream>`, `using namespace std;` |
| hpp | C 风格 | `#ifndef/#define __XXX_HPP__ / #endif` |
| h | C 风格 | `#include <stdio.h>` |
| c | C 风格 | `#include <stdio.h>` |
| 其他 (.java 等) | C 风格 | 无额外 include |

#### 快速插入日志 — InsertLog()

插入格式: `printf("======> lhj add file:%s func:%s line:%d \n", __FILE__, __func__, __LINE__);`

---

### plugins_list.vim — 插件列表 (205行)

按功能分组（Plugin 命令对 Vundle/vim-plug 通用）:

| 分类 | 插件 | 用途 |
|------|------|------|
| 启动界面 | vim-startify | 启动屏幕/最近文件 |
| 文件浏览 | NERDTree, fzf, ctrlp, tagbar | 文件树/模糊搜索/符号列表 |
| 编辑增强 | indentLine, easymotion, accelerated-jk, open-browser, commentary, vim-mark, tabular | 缩进线/快速移动/链接打开/注释对齐/高亮标记 |
| 剪贴板 | vim-yankstack | 剪贴板历史栈 |
| 补全 | YouCompleteMe | 代码补全引擎 (完整克隆 shallow=0) |
| 语法检查 | ALE | 异步 lint |
| 代码片段 | UltiSnips, vim-snippets | 片段引擎 + 片段库 |
| LaTeX | vimtex | LaTeX 编辑支持 |
| 语法高亮 | vim-polyglot (Mac), vim-c-cpp-modern | 多语言/C++增强 |
| 主题 | gruvbox, tokyonight, dracula, solarized, nord, jellybeans, onedark, molokai | 配色方案 |
| 界面 | vim-devicons, vim-airline, vim-airline-themes | 图标/状态栏 |
| Markdown | vim-markdown, vim-markdown-toc, mathjax-support-for-mkdp, markdown-preview | 编辑/TOC/预览 |
| PlantUML | plantuml-syntax, plantuml-previewer, vim-slumlord, preview-uml | UML 支持 |
| 剪贴板同步 | vim-oscyank | SSH/TMUX 中剪贴板同步 |
| 成对符号 | vim-surround, auto-pairs | 括号引号操作/自动配对 |
| 其他 | undotree, vim-illuminate, vim-lastplace, Colorizer, vim-peekaboo, ferret | 撤销树/光标高亮/位置恢复/颜色预览/寄存器可视化/全局替换 |

---

### plugins/ — 插件详细配置

| 文件 | 主要配置项 |
|------|-----------|
| ui.vim | startify (自定义列表/快捷键), airline (theme=bubblegum/powerline_fonts), NERDTree (映射/宽度/图标), devicons, illuminate, lastplace |
| search.vim | ctrlp (忽略模式/映射), fzf (CTRL-F/CTRL-P), ack/ag, tagbar (映射/图标), gtags (完整配置) |
| git.vim | fugitive (映射), gitgutter (signcolumn), blame (自动关闭) |
| code.vim | YCM (路径/补全行为), ALE (C/C++ linter), ctags (关闭自定义高亮), surround, camelcasemotion, smartrename (F2) |
| snippet.vim | ultisnips (扩展名/触发键), yankstack, peekaboo |
| lang.vim | vimtex (编译器/查看器/QuickFix), markdown (折叠/映射), plantuml, json, yaml |
| misc.vim | oscyank (SSH剪贴板), easymotion ( leader/2键), tabular, commentary, mark |
| gtags.vim | GNU Global/Pygments 配置 (18KB 大文件) |

---

### pm_vimplug.vim / pm_vundle.vim — 插件管理器

两个文件结构对称，功能相同:

```
set nocompatible
[管理器初始化]          # plug#begin 或 vundle#begin
source plugins_list.vim # 共享插件列表
[管理器结束]            # plug#end 或 vundle#end
filetype plugin indent on  # 文件类型检测（三合一）
```

- `plugin_manager.vim` 是指向 `pm_vimplug.vim` 的软链接（默认使用 vim-plug）
- 如需切换到 Vundle，修改软链接目标即可

---

### commoncfg.vim — 已废弃

保留作为参考，记录了旧版单文件配置的迁移目标:
- 01_basic.vim ← 基本选项
- 02_theme.vim ← 主题
- 03_format_build.vim ← 格式化
- 04_mappings.vim ← 映射
- 05_autocmds.vim ← 自动命令
- 06_functions.vim ← 函数

---

## 设计决策记录

1. **F5/F6 优先级**: prjBuild.sh(当前) > prjBuild.sh(git root) > CMake/Make/meson(git root) > 单文件编译
2. **编译 silent / 运行暂停**: compilecmd 用 `silent exec`（不暂停），excmd 用 `exec`（暂停看输出）
3. **-Wall -Wextra**: c/cpp 编译和调试均启用
4. **CheckGitRootFile/ExecGitRootTool**: 保持双参数签名 `(root,file)` / `(cmd,root)`，内部不 cd 切换工作目录
5. **BufWritePre 作用域**: 05_autocmds.vim 限定代码文件；03_format_build.vim 为全文件类型（两者并存）
6. **autocmd 统一管理**: 所有 autocmd 在 05_autocmds.vim，按 augroup 分组
7. **filetype 检测**: 由 plugin_manager.vim 在插件加载后统一执行 `filetype plugin indent on`
8. **F2 冲突**: 04_mappings.vim 映射为"去空行"，plugins/code.vim 中 SmartRename 也用 F2，后者覆盖前者
