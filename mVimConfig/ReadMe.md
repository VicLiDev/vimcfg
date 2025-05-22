# 仓库使用方法

> Put vimrcs colors syntax into ~/.vim  
> 注意 syntax 中的c.vim需要首先复制系统中的c.vim，然后在后边添加文件夹中c.vim中的内容

建议创建软链接
- ln -s ${HOME}/Projects/vimcfg/mVimConfig ${HOME}/.vim
- ln -s ${HOME}/Projects/vimcfg/mVimConfig/vimrc ${HOME}/.vimrc
- ln -s ${HOME}/Projects/vimcfg/mVimConfig/gdbinit ${HOME}/.gdbinit
- ln -s ${HOME}/Projects/vimcfg/mVimConfig/gdb_tools ${HOME}/.gdb

for gdb
- gef: git clone https://github.com/hugsy/gef.git ~/.gdb/gef
- peda: git clone https://github.com/longld/peda.git ~/.gdb/peda
- dashboard:
  - wget https://github.com/cyrus-and/gdb-dashboard/raw/master/.gdbinit -O ~/.gdb/gdbdashboard
  - pip install pygments
- libheap
  - git clone https://github.com/cloudburst/libheap ~/.gdb/libheap
  - pip3 install --user ~/.gdb/libheap/
  - sudo apt-get install libc6-dbg

# vim Tutorials

## Common settings

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

### autocmd:

自动命令，是在指定事件发生时自动执行的命令，比如自定义以下函数，用于在文件中插入当前日期：

```
function DateInsert()
    $read !date
    endfunction
```
使用以下命令，可以手动调用此函数：
```
call DateInsert()
```
而通过以下自动命令，则可以在保存文件时自动执行函数，而不再需要额外的手动操作：
```
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
- BufEnter: 当进入缓冲区时触发。这在你切换到不同的文件时非常有用，比如自动设置一些
  选项或执行特定的命令。
- BufLeave: 当离开缓冲区时触发。这可以用于在离开文件前执行清理工作，比如保存设置
  或更新状态。
- BufNewFile: 当创建新文件时触发。这可以用于设置新文件的默认格式或内容。
- BufRead: 当读取缓冲区时触发，通常是在打开文件时。这可以用于为特定类型的文件设置
  特定的设置或执行命令。
- BufReadPost: 在 BufRead 之后触发，这允许你在文件完全加载后执行命令。
- BufWrite: 在写入缓冲区到文件之前触发。这可以用于在保存文件之前执行检查或修改。
- BufWritePost: 在写入缓冲区到文件之后触发。这可以用于在文件保存后执行操作，比如
  更新其他文件或触发外部程序。
- CursorHold: 当光标停止移动一定时间后触发。这可以用于自动格式化代码或执行其他
  需要定时触发的操作。
- CursorHoldI: 与 CursorHold 类似，但仅在插入模式下触发。
- FileReadCmd: 当执行文件读取命令（如 :read）时触发。
- FileReadPost: 在文件读取命令完成后触发。
- FileWriteCmd: 当执行文件写入命令（如 :write）时触发。
- FileWritePost: 在文件写入命令完成后触发。
- FileType: 当文件类型被设置时触发。Vim 会根据文件内容或扩展名自动设置文件类型，

或者可以手动设置。这允许你为不同类型的文件设置不同的配置。
- InsertEnter: 当进入插入模式时触发。
- InsertLeave: 当离开插入模式时触发。
- VimEnter: Vim 启动并读取 .vimrc 文件后触发。这通常用于执行启动时的初始化设置。
- VimLeave: Vim 退出前触发。这可以用于执行清理工作，比如保存会话或设置。
- VimLeavePre: 在 VimLeave 之前触发，允许你在 Vim 完全退出前执行命令。
- WinEnter: 当进入窗口时触发。这在分割窗口或切换窗口时非常有用。
- WinLeave: 当离开窗口时触发。

使用以下命令，可以列出所有自动命令：
```
:autocmd
```

## key map
 https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)

### general

几种模式的介绍
- Normal Mode：也就是最一般的普通模式，默认进入vim之后，处于这种模式。
- Visual Mode：一般译作可视模式，在这种模式下选定一些字符、行、多列。
               在普通模式下，可以按v进入。
- Insert Mode：插入模式，其实就是指处在编辑输入的状态。普通模式下，可以按i进入。
- Select Mode：选择模式。用鼠标拖选区域的时候，就进入了选择模式。和可视模式
               不同的是，在这个模式下，选择完了高亮区域后，敲任何按键就直接
               输入并替换选择的文本了。和windows下的编辑器选定编辑的效果一致。
               普通模式下，可以按gh进入。
- Command-Line/Ex Mode：命令行模式和Ex模式。两者略有不同，普通模式下按冒号(:)
               进入Command-Line模式，可以输入各种命令，使用vim的各种强大功能。
               普通模式下按Q进入Ex模式，其实就是多行的Command-Line模式。

正常模式（即命令模式或普通模式）、插入模式、命令行模式、可视模式、选择模式、操作员待定模式

```
The general syntax of a map command is:
{cmd} {attr} {lhs} {rhs}

where
{cmd}  is one of ':map', ':map!', ':nmap', ':vmap', ':imap',
       ':cmap', ':smap', ':xmap', ':omap', ':lmap', etc.
{attr} is optional and one or more of the following: <buffer>, <silent>,
       <expr> <script>, <unique> and <special>.
       More than one attribute can be specified to a map.
{lhs}  left hand side, is a sequence of one or more keys that you will use
       in your new shortcut.
{rhs}  right hand side, is the sequence of keys that the {lhs} shortcut keys
       will execute when entered.
```

### create maps

创建映射的步骤：
1. 确定映射将要运行的键的顺序。 当您调用映射时，Vim会执行键序列，就像从键盘上输入
   它一样。
2. 确定映射应在其中工作的编辑模式（插入模式，可视模式，命令行模式，普通模式等）。
   与其创建适用于所有模式的映射，不如定义仅适用于选定模式的映射。
3. 找到可用于调用映射的未使用键序列。您可以使用单个键或键序列来调用映射。

将映射命令添加到文件时，命令前可以不加':'字符。

### display maps

您可以使用以下命令（不带任何参数）显示现有键映射的列表：
- :map  显示普通模式、可视模式、选择模式、操作员待定模式的映射
- :map! 显示插入模式、命令行模式的映射
- :nmap-显示普通模式映射
- :imap-显示插入模式映射
- :vmap-显示可视、选择模式映射
- :smap-显示选择模式映射
- :xmap-显示可视模式映射
- :cmap-显示命令行模式映射
- :omap-显示操作员待定模式映射

### remove a key map

要永久删除映射，首先需要使用`：verbose map {lhs}`命令（用映射的键序列替换{lhs}）
来定位它的定义位置。如果在.vimrc或_vimrc文件或vimfiles或.vim目录中的文件之一中
定义了映射，则可以编辑该文件以删除该映射。另一种方法是使用`：unmap'和'：unmap!`。
命令删除映射。 例如，要删除<F8>键的映射，可以使用以下命令：

可以使用特定于模式的unmap命令删除特定于模式的映射。 下面列出了特定于模式的unmap命令：
- nunmap - Unmap a normal mode map
- vunmap - Unmap a visual and select mode map
- xunmap - Unmap a visual mode map
- sunmap - Unmap a select mode map
- iunmap - Unmap an insert and replace mode map
- cunmap - Unmap a command-line mode map
- ounmap - Unmap an operator pending mode map

要清除特定模式下的所有映射，可以使用'：mapclear'命令。 特定于模式的map clear命令如下所示：
- mapclear  - Clear all normal, visual, select and operating pending mode maps
- mapclear! - Clear all insert and command-line mode maps
- nmapclear - Clear all normal mode maps
- vmapclear - Clear all visual and select mode maps
- xmapclear - Clear all visual mode maps
- smapclear - Clear all select mode maps
- imapclear - Clear all insert mode maps
- cmapclear - Clear all command-line mode maps
- omapclear - Clear all operating pending mode maps

### Mode-specific maps 

Vim支持创建仅在特定编辑模式下起作用的键盘映射。 您可以创建仅在正常，插入，可视，
选择，命令和操作员待定模式下起作用的键盘映射。 下表列出了各种映射命令及其相应的
编辑模式：

| Commands               | Mode                    |
|------------------------|-------------------------|
| nmap, nnoremap, nunmap | Normal mode             |
| imap, inoremap, iunmap | Insert and Replace mode |
| vmap, vnoremap, vunmap | Visual and Select mode  |
| xmap, xnoremap, xunmap | Visual mode             |
| smap, snoremap, sunmap | Select mode             |
| cmap, cnoremap, cunmap | Command-line mode       |
| omap, onoremap, ounmap | Operator pending mode   |


### Mapping mouse events
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

## Plug-in installation and configuration

## Custom function (vimscript)

参考：https://www.ibm.com/developerworks/cn/linux/l-vim-script-2/index.html
Vimscript 中的函数使用 function 关键字定义，后跟函数名，然后是参数列表（这是强制的，
即使该函数没有参数）。函数体然后从下一行开始，一直连续下去，直到遇到一个匹配的
endfunction 关键字。

### 基本语法

1. 函数返回值使用 return 语句指定。可以根据需要指定任意数量的单独 return 语句。
   如果函数被用作一个过程，并且没有任何有用的返回值，那么可以不包含 return 语句。
   然而，Vimscript 函数始终 返回一个值，因此如果没有指定任何 return，那么函数将
   自动返回 0。
2. Vimscript 中的函数名必须以大写字母开头。
3. 可以使用显式的范围前缀声明函数，最常见的选择是 s:，它表示函数对于当前脚本文件
   是本地函数。如果函数使用这种方式确定范围，那么它的名称就不需要以大写开头；它
   可以是任意有效标识符。然而，显式确定范围的函数必须始终使用范围前缀进行调用。
   例如：
   ```
   function s:save_backup ()
     let b:backup_count = exists('b:backup_count') ? b:backup_count+1 : 1
     return writefile(getline(1,'$'), bufname('%') . '_' . b:backup_count)
   endfunction

   nmap <silent>  <C-B>  :call s:save_backup()<CR>
   ```
4. 重新声明函数被看作一种致命的错误（这样做是为了防止发生两个不同脚本同时声明函数
   的冲突）。这使得很难在需要反复加载的脚本中创建函数，比如自定义的语法突出显示脚本。
   因此 Vimscript 提供了一个关键字修饰符（function!），允许在需要时指出某个函数声明
   可以被安全地重载：
   例如：
   ```
   function! s:save_backup ()
     let b:backup_count = exists('b:backup_count') ? b:backup_count+1 : 1
     return writefile(getline(1,'$'), bufname('%') . '_' . b:backup_count)
   endfunction
   ```
   对于使用这个修饰过的关键字定义的函数，没有执行任何重新声明检查，因此非常适合
   用于显式确定范围的函数（在这种情况下，范围已经确保函数不会和其他脚本中的函数
   发生冲突）。

### 调用函数

要调用函数并使用它的返回值作为语言表达式的一部分，只需要命名它并附加一个使用
圆括号括起的参数列表：let success = setline('.', ExpurgateText(getline('.')) )
但是要注意，与 C 或 Perl 不同，Vimscript 并不 允许您在未使用的情况下抛出函数的
返回值。因此，如果打算使用函数作为过程或子例程并忽略它的返回值，那么必须使用
call 命令为调用添加前缀：call SaveBackup()
否则，Vimscript 将假设该函数调用实际上是一个内置的 Vim 命令，并且很可能会发出
报警，指出并不存在这类命令。

### 参数列表

 Vimscript 允许您定义显式参数 和可变参数列表，甚至可以将两者结合起来。
 1. 在声明了子例程的名称后，您可以立即指定最多 20个显式命名的参数。指定参数后，
    通过将 a:前缀添加到参数名，可以在函数内部访问当前调用的相应参数值：
     function PrintDetails(name, title, email)
       echo 'Name:   '  a:title  a:name
       echo 'Contact:'  a:email
     endfunction
 2. 如果您不清楚一个函数具有多少个参数，那么可以指定一个可变的参数列表，使用
    省略号（...）而不是命名参数。函数可以使用任意数量的参数调用，并且这些值被
    收集到一个单一变量中：一个名为 a:000 的数组。为单个参数也提供了位置参数名：
    a:1、a:2、a:3，等等。参数的数量可以是 a:0。
    ```
    function Average(...)
        let sum = 0.0

        for nextval in a:000"a:000 is the list of arguments
            let sum += nextval
        endfor
        return sum / a:0"a:0 is the number of arguments

    endfunction
    ```
    注意，在本例中，sum 必须被初始化为一个显式的浮点值；否则，所有后续计算都将
    使用整数运算计算。
 3. 可以在同一个函数中同时使用命名参数和可变参数，只需要将可变参数的省略号放在
    命名参数列表之后。

## Custom command

在 Vimscript 中，`function!` 和 `command!` 是两种不同的定义方式，用于创建函数和
自定义命令。它们的用途和语法有显著区别。

### `function!` 和 `command!` 的区别

| 特性           | `function!` (函数)                      | `command!` (自定义命令)              |
|----------------|-----------------------------------------|--------------------------------------|
| **用途**       | 定义可复用的 Vimscript 函数             | 定义可在命令行模式 (`:`) 调用的命令  |
| **调用方式**   | `:call MyFunc()`                        | `:MyCommand`                         |
| **作用域**     | 可指定 `s:`（脚本局部）、`g:`（全局）等 | 默认全局可用                         |
| **参数处理**   | 通过 `a:1`, `a:2` 访问                  | 通过 `<args>`, `<f-args>` 等特殊标记 |
| **覆盖行为**   | `function!` 允许覆盖同名函数            | `command!` 允许覆盖同名命令          |
| **适用场景**   | 复杂逻辑、代码复用                      | 快速封装常用操作                     |

### `command!` 的完整语法

`command!` 用于定义 Ex 命令（即在 Vim 命令行模式输入的命令）。其基本语法如下：
```vim
command! [options] {cmd_name} {cmd_body}
```

#### 常用选项 (`[options]`)
| 选项            | 说明                                                                 |
|-----------------|----------------------------------------------------------------------|
| `-bang`         | 允许命令后加 `!`（如 `:MyCommand!`），可通过 `<bang>` 访问           |
| `-nargs=`       | 指定参数数量：<br> `0`（无参数）<br> `1`（1个参数）<br> `*`（任意数量）<br> `?`（0或1个）<br> `+`（至少1个） |
| `-complete=`    | 启用参数补全（如 `-complete=file` 补全文件名）                       |
| `-range`        | 允许接收行范围（如 `:1,10MyCommand`），通过 `<line1>`, `<line2>` 访问|
| `-bar`          | 允许在命令后跟 `\|` 执行其他命令（如 `:MyCommand \| echo "Done"`）   |

#### 参数传递 (`{cmd_body}`)
在命令体中，可以通过特殊标记引用参数：
| 标记            | 说明                                                   |
|-----------------|--------------------------------------------------------|
| `<args>`        | 所有参数（字符串形式）                                 |
| `<f-args>`      | 参数列表（适合传递给函数，如 `call MyFunc(<f-args>)`） |
| `<bang>`        | 如果命令带 `!`，值为 `"!"`，否则为空                   |
| `<line1>`, `<line2>` | 行范围（需配合 `-range` 使用）                    |
| `<q-args>`      | 引号包裹的参数（避免空格拆分）                         |

#### 示例
(1) 无参数命令
```vim
command! Hello echo "Hello, Vim!"
```
调用：
```vim
:Hello  " 输出 Hello, Vim!
```
(2) 带 `!` 和参数
```vim
command! -bang -nargs=* SayHi echo "Hi," <q-args> . (<bang> == "!" ? "!" : ".")
```
调用：
```vim
:SayHi World   " 输出 Hi, World.
:SayHi! World  " 输出 Hi, World!
```
(3) 调用函数
```vim
function! Greet(name) abort
  echo "Hello, " . a:name
endfunction

command! -nargs=1 Greet call Greet(<f-args>)
```
调用：
```vim
:Greet Alice  " 输出 Hello, Alice
```
(4) 带行范围
```vim
command! -range=% ShowLines echo "Lines: " . <line1> . "-" . <line2>
```
调用：
```vim
:10,20ShowLines  " 输出 Lines: 10-20
```

### `command!` 在 `:Agit` 中的应用

回到 `:Agit` 命令：
```vim
command! -bang -nargs=* Agit
  \ let s:ag_saved_cwd = getcwd() |
  \ let s:is_git = system('git rev-parse --is-inside-work-tree 2>/dev/null') =~ 'true' |
  \ let s:ag_git_root = s:is_git ?
  \   trim(system('git rev-parse --show-toplevel 2>/dev/null')) : '' |
  \ if !empty(s:ag_git_root) |
  \   silent execute 'lcd' fnameescape(s:ag_git_root) |
  \ endif |
  \ try |
  \   call fzf#vim#ag(<q-args>,
  \     extend({'options': '--delimiter : --nth 4..'},
  \     fzf#vim#with_preview()),
  \     <bang>0) |
  \ catch /E117/ |
  \   echoerr 'fzf.vim not installed or ag not found!' |
  \ endtry |
  \ silent execute 'lcd' fnameescape(s:ag_saved_cwd)
```
- **`-bang`**: 支持 `:Agit!` 调用（传递给 `fzf#vim#ag` 的 `<bang>0`）。
- **`-nargs=*`**: 接受任意数量的参数（搜索词）。
- **`<q-args>`**: 保留参数中的空格（如 `:Agit "foo bar"`）。
- **`\`**: 续行符，用于多行命令。

这里 | 用于将多个 Vim 语句连接成一行（因为 command! 要求命令体必须是单行）


## 不错的vim教程：
简明 VIM 练级攻略
https://coolshell.cn/articles/5426.html
vim操作全面讲解
http://www.cnblogs.com/hustskyking/archive/2013/06/11/linux-learning-details.html
Vim 的纵向编辑模式
https://www.ibm.com/developerworks/cn/linux/l-cn-vimcolumn/index.html

