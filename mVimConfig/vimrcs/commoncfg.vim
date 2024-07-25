"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 常用函数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" echo {message}: 在屏幕底部显示消息。
" echom {message}: 类似于 echo，但会将消息添加到消息历史记录中，可以通过 :messages 命令查看。
" execute {command}: 执行一个 Ex 命令。
" normal {commands}: 执行普通模式下的命令。
" map {keys} {action}: 将一个键映射到另一个动作或命令。
" let {variable} = {value}: 声明或修改变量的值。
" set {option}?: 获取选项的值。
" set {option}={value}: 设置选项的值。
" exists({expression}): 检查变量、函数、映射等是否存在。
" has({feature}): 检查 Vim 是否支持某个特性。
" system({command}): 执行一个外部命令并返回其输出。
" split({string}, {separator}, {keepempty}): 将字符串分割成列表。
" join({list}, {separator}): 将列表元素连接成一个字符串。
" filter({list}, {lambda}): 过滤列表，返回满足条件的元素组成的列表。
" len({collection}): 返回集合（如字符串、列表、字典）的长度。
" tolower({string}): 将字符串转换为小写。
" toupper({string}): 将字符串转换为大写。
" substitute({string}, {pattern}, {replacement}, {flags}): 在字符串中执行查找和替换。
" matchstr({string}, {pattern}, {flags}): 在字符串中查找匹配的子串。
" getline({start}, {end}): 获取指定行范围的文本。
" setline({line}, {text}): 设置指定行的文本。
" append({line}, {text}): 在指定行后追加文本。
" indent({line}): 获取或设置指定行的缩进。
" exepath(): 获取一个外部程序的可执行文件路径，例如：:echo "bash_path: ".exepath("bash")
"            如果找到指定的程序，则返回程序的可执行文件路径；如果没有找到，则返回一个空字符串。
" executable(): 检查指定的程序是否可执行，即是否存在于系统的 PATH 环境变量指定的
"               路径中，并且用户有执行权限。果程序可执行，则返回 1；如果不可执行
"               或不存在，则返回 0。
"
" append({lnum}, {line}): 在指定行号之后追加一行或多行文本。
"     {lnum}: 指定要在其后追加文本的行号。
"     {line}: 要追加的文本行。这可以是一个字符串，也可以是一个字符串列表，如果是
"             一个列表，则每一项都会被追加到缓冲区中。
"     返回值: 返回追加的最后一行的行号
"
" setline({lnum}, {line}): 设置指定行的文本内容。如果指定行不存在，它将创建新行。
"     {lnum}: 指定要设置文本的行号。
"     {line}: 要设置的文本行。这可以是一个字符串，也可以是一个字符串列表，如果是
"             一个列表，则列表中的每一项将替换从 {lnum} 开始的连续多行。
"
" line({expr}): 返回缓冲区中指定表达式的行号，或者如果 {expr} 是一个行号，则返回
"     该行的文本内容。
"     {expr}: 可以是一个行号，或者一个特殊的表达式，如 '.' 表示当前行，'$'表示
"             最后一行。
"     返回值: 如果 {expr} 是一个行号，则返回该行的文本内容；如果 {expr} 是一个
"             特殊表达式，则返回相应的行号。


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基本设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nocompatible就是不兼容的。具体是不兼容什么，简单点说就是很老的vi的格式。vim是
" vi的扩展，nocompatible就是指vim在工作的时候不需要考虑和vi兼容。
set nocompatible

" vim与系统的剪贴板一起交互使用。使用前，使用命令: vim --version | grep clipboard
" 看看自己的计算机的vim版本。如果出现“-clipboard”则说明系统的vim版本不支持与系统
" 剪贴板的交互操作，需要采用如下的命令安装新的vim：sudo apt install vim-gtk 安装
" 完成之后再利用代码检查一次，出现“+clipboard”，那么系统的vim没有问题。
set clipboard+=unnamed

set ignorecase "搜索忽略大小写
set smartcase " 当有大写时，关注大小写
set hlsearch "搜索逐字符高亮
set incsearch  "即时搜索预览，不起作用，不知道原因

set report=0  " 通过使用: commands命令，告诉我们文件的哪一行被改变过，不知道有什么用

if has('win32') || has('linux')
    " 高亮显示普通txt文件（需要txt.vim脚本），不知道有什么用 可能会导致macos的vim高亮失效
    au BufRead,BufNewFile *  setfiletype txt
elseif has('mac')
endif

" set linespace=-500  " 字符间插入的像素行数目，不起作用   会影响gvim显示


" 使用'wildmenu'选项，将启用增强模式的命令行补全。在命令行中输入命令时，按下
" 'wildchar'键（默认为Tab）将自动补全命令和参数：此时将在命令行的上方显示可能的
" 匹配项；继续按下'wildchar'键，可以遍历所有的匹配项；也可以使用方向键或者
" CTRL-P/CTRL-N键，在匹配列表中进行移动；最后点击回车键，选择需要的匹配项。
set wildmenu

" menu：使用弹出菜单显示可能的补全。 仅当存在多个匹配项并且有足够的颜色可用时，
" 才会显示菜单。  preview：在预览窗口中显示有关当前选定完成的更多信息。 仅与
" “菜单”或“菜单”组合使用。
set completeopt=preview,menu

set backspace=indent,eol,start  " 设置退格键的作用
" indent: 如果用了:set indent,:set ai 等自动缩进，想用退格键将字段缩进的删掉，
"         必须设置这个选项。否则不响应。
" eol:如果插入模式下在行开头，想通过退格键合并两行，需要设置eol。
" start:要想删除此次插入前的输入，需设置这个。

set scrolloff=5  " 垂直滚动时，光标距离顶部/底部的位置（单位：行）。
set sidescrolloff=15  " 水平滚动时，光标距离行首或行尾的位置（单位：字符）。

set iskeyword+=_,$,@,%,#,-  " 带有如下符号的单词不要被换行分割
set showcmd  " 在屏幕底部显示当前所处的模式。例如希望输入fx命令来查找字符“x”时，
             " 当我们输入f时就会在底部显示“f”，这在输入复杂命令时将很有帮助。
set showmode " 在底部显示当前处于命令模式还是插入模式

" jump to the last position when reopening a file
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""""""""""""""""""""""""""""
" 窗口设置
""""""""""""""""""""""""""""
"winpos 5 5          " 设定窗口位置
"set lines=40 columns=155    " 设定窗口大小
" set cmdheight=2     " 命令行（在状态行下）的高度，设置为2,默认为1
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)

" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容

" set noeb "意思是noerrorbells,意思是当出现错误时没有提示
" set vb "vb:visualbell，可视的响铃，意思是用屏幕的闪烁代替响铃。
" set vb t_vb= "但在gvim中，noeb是不生效的，可以用这条指令替换，效果和set vb相同，且在vi/vim/gvim中都有效。

""""""""""""""""""""""""""""
" 显示设置
""""""""""""""""""""""""""""
syntax on "自动语法高亮
set number         " 显示行号
colorscheme gruvbox  "设置配色方案
" color darkblue "设置背景主题，跟colorscheme好像是一样的
set background=dark "背景使用黑色
" set fillchars=vert:\ ,stl:\ ,stlnc:\  " 在被分割的窗口间显示空白，便于阅读

set ruler  " 显示标尺，标尺显示文件中的光标位置。
set colorcolumn=80 " 您可以使用：set colorcolumn（简称：set cc）选项在特定列显示标尺，
                   " 该选项仅在Vim 7.3或更高版本中可用。
set cursorline " 突出显示当前行，在当前行下边画一条线
" set cursorcolumn " 突出显示当前列，在当前行下边画一条线

set showmatch  " 设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set matchtime=1  " 匹配括号高亮的时间（单位是十分之一秒）

" window版本的Gvim下默认的界面非常丑,可以通过在配置文件_vimrc上设置guioptions来
" 个性化你的MS-Gvim. 可以用过 :h guioptions 来查看帮助.
" set guioptions-=T           " 隐藏工具栏
" set guioptions-=m           " 隐藏菜单栏

autocmd InsertLeave * se nocul  " 用浅色高亮当前行，不知道为啥没用
autocmd InsertEnter * se cul    " 用浅色高亮当前行，不知道为啥没用

" hi Normal: 指的是 Vim 的 Normal 高亮组，这通常是用于在普通模式（不是插入、可视
" 或其他特殊模式）下显示的文本。
" ctermfg=252: 设置终端前景色（文本颜色）为颜色代码 252。在大多数 256 色终端中，
" 颜色代码 252 通常表示一个非常浅的灰色或白色。
" ctermbg=none: 设置终端背景色为“无”或透明。这意味着文本的背景将使用终端的默认
" 背景色。
" 会受 vimtex 插件 syntax enable 的影响，因此这里不生效
" hi Normal ctermfg=252 ctermbg=none
hi Normal ctermbg=none

""""""""""""""""""""""""""""
" 语言设置
""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8  " 设置gvim的菜单语言
set helplang=cn  " 设置帮助文档的语言
" set guifont=Courier_New:h10:cANSI   " 设置字体  gVim

""""""""""""""""""""""""""""
" 文件操作
""""""""""""""""""""""""""""
set autoread  " 打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器
              " 编辑了），就会发出提示。不知道为什么不起作用
set confirm " 在处理未保存或只读文件的时候，弹出确认
set autowrite  " autowrite命令用于在关闭文件时自动保存文件中所做的更改。不知道有什么用

" set noundofile  "在使用vim编辑文件后，会有一个后缀为.un~的文件生成，该文件记录
                  " 当前正在编辑文件的修改，保证下次打开时可以继续上次的编辑，可以
                  " 撤销到上次关闭之前。使用改命令可以关闭。使用set undofile打开。
                  " 若想使用该功能的话，但不想被那些文件烦的话，可以指定文件夹 undodir=~/.undodir
" set nobackup "在使用vim编辑文件后，总是会有一个以.swp 结尾的文件自动生成，关闭
               "文件之后这个文件会自动消失，这个文件是当前编辑文件的备份文件，不需要
               "这个文件的话可以使用这条设置
" set noswapfile  "类似set nobackup

" set history=500  " 命令历史记录数量

""""""""""""""""""""""""""""
" 编译运行
""""""""""""""""""""""""""""
" 对于c，cpp文件，可以使用\<空格>组合，执行当前目录下的MakeFile文件
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
" vim提供了:make来编译程序，默认调用的是make， 如果你当前目录下有makefile，简单
" 地:make即可。如果你没有make程序，你可以通过配置makeprg选项来更改make调用的程序。
"set makeprg=g++\ -Wall\ \ %

""""""""""""""""""""""""""""
" 保存会话（session）信息
""""""""""""""""""""""""""""
" Vm使用viminfo选项，来定义如何保存会话（session）信息，也就是保存Vim的操作记录和
" 状态信息，以用于重启Vim后能恢复之前的操作状态。
set viminfo+=!
" viminfo文件默认存储在以下位置：
"     Linux和Mac：$HOME/.viminfo，例如：~/.viminfo
"     Windows：$HOME\_viminfo，例如：C:\Users\yiqyuan\_viminfo
" viminfo文件主要保存以下内容：
"     Command Line History（命令行历史纪录）
"     Search String History（搜索历史纪录）
"     Expression History（表达式历史纪录）
"     Input Line History（输入历史记录）
"     Debug Line History（调试历史纪录）
"     Registers（寄存器）
"     File marks（标记）
"     Jumplist（跳转）
"     History of marks within files（文件内标记）
" Vim在退出时，会将上述信息存放到viminfo文件中；在启动时，将会自动读取viminfo信息文件。

""""""""""""""""""""""""""""
" 鼠标设置
""""""""""""""""""""""""""""

" ‘mouse’的参数说明
"    n  普通模式
"    v  可视模式
"    i 插入模式
"    c 命令行模式
"    h 在帮助文件里，以上所有模式
"    a 以上所有模式
"    r 跳过|lit-enter|提示
"    A 在可是模式下自动选择
" 'mouse' 的缺省值为空，即不使用鼠标。

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a  " 可以通过鼠标点击，光标是否移动来判断有没有启用鼠标
" 在所有模式之下，鼠标左键可以移动光标，拉动左键可以选择文本。
" 在extend模式中，可以使用左键点中起始位置，然后按住Alt键的同时右击结束位置，
"                 将选中两点定义的可视化块（visual block）。
" 在popup模式中，右键可以显示弹出菜单。
" 而popup_setpos模式与popup模式相类似，所不同的只是当按下鼠标右键时，光标会移动到
" 鼠标点击处，然后显示弹出菜单。
" set mousemodel=popup  " Set the behaviour of mouse
" set selection=exclusive  " 此选项定义选择的行为。 仅在可视和选择模式下使用。具体
                           " 可用 :help selection 查看
" set selectmode=mouse,key  " 这是一个用逗号分隔的列表，它指定了开始选择时何时启动
                            " 选择模式而不是可视模式。 可能的值：mouse:使用鼠标时的
                            " 鼠标 key:使用移位特殊键时的键 cmd:使用“ v”，“ V”或CTRL-V时的cmd

""""""""""""""""""""""""""""
" whichwrap
""""""""""""""""""""""""""""
" 默认情况下，在 VIM 中当光标移到一行最左边的时候，我们继续按左键，光标不能回到
" 上一行的最右边。同样地，光标到了一行最右边的时候，我们不能通过继续按右跳到下一行的
" 最左边。但是，通过设置 whichwrap 我们可以对一部分按键开启这项功能。如果想对某一个
" 或几个按键开启到头后自动折向下一行的功能，可以把需要开启的键的代号写到 whichwrap 的
" 参数列表中，各个键之间使用逗号分隔。以下是 whichwrap 支持的按键名称列表：
" b 在 Normal 或 Visual 模式下按删除(Backspace)键。
" s 在 Normal 或 Visual 模式下按空格键。
" h 在 Normal 或 Visual 模式下按 h 键。
" l 在 Normal 或 Visual 模式下按 l 键。
" < 在 Normal 或 Visual 模式下按左方向键。
" > 在 Normal 或 Visual 模式下按右方向键。
" ~ 在 Normal 模式下按 ~ 键(翻转当前字母大小写)。
" [ 在 Insert 或 Replace 模式下按左方向键。
" ] 在 Insert 或 Replace 模式下按右方向键。

" set whichwrap=b,s,<,>,[,]  " 不知道为什么这样设置不好使，在vim里用命令行设置是好用的

""""""""""""""""""""""""""""
" 自动补全
""""""""""""""""""""""""""""
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

""""""""""""""""""""""""""""
" maigc
""""""""""""""""""""""""""""

" vim在进行搜索时可以使用正则表达式，但对于只想原原本本按用户指定文本做简单的搜索和
" 替换来说，正则表达式中大量字符被定义为具有特殊含义的元字符（元字符为描述字符的字符，
" 它不直接表示该字符本身）会造成诸多不便：比如想搜索文本“$5.2*3”，因为$.*都有特别的
" 含义，不改写的情况下永远不会有预期结果，而正确搜索需要写成“\$5\.2\*3”，对普通用户
" 来说非常不友好。
" 为兼顾以字符主要表示本身，以及大量运用元字符这两种完全不同的倾向，VIM对于模式提供了
" 4种选项：very magic、magic、nomagic、very nomagic。其中magic、nomagic可以通过set设置
" 为模式的默认选项，而所有4种选项皆可在模式中多次通过开关来临时切换：
"     \v very magic
"     \m magic
"     \M nomagic
"     \V very nomagic
" 如果环境set magic的话，则搜索：
"     /abc\vdef\Vghi\Mjkl
"     表示按magic解释abc，按very magic解释def，按very nomagic解释ghi，按nomagic解释jkl。
"
" VIM官方推荐设置为magic，然后需要使用其他选项时用开关切换。
"
" 4种选项中，带有no的倾向字符表示字符本身，而不带no的倾向字符具有特殊含义；带有
" very的则处于两个极端，不带very的居中。4种选项的具体区别：
"     \v指定very magic：所有ASCII字符中（即键盘上能看到的字符），除了数字（0-9）、
"                       大小写字母（A-Za-z）和下划线（_）外，全都有特殊含义。
"     \V指定very nomagic：大多数字符都表示其本身，除了反斜杠\，以及用来表示模式起止的分隔符（如/或?）。
"     \m指定magic：^ $ . * ~ []等具有特殊含义。当然，反斜杠和表达模式起止的分隔符也算具有特殊含义。
"     \M指定nomagic：仅 ^ $具有特殊含义。当然，反斜杠和表达模式起止的分隔符也算具有特殊含义。
" 通过定义可以看出：
"     \v适合大量运用正则表达式的场合；
"     \V适用于完全不使用正则表达式的原文搜索；
"     \m使用少量的正则表达式，包括起止锚点、任意字符、0次以上出现、最近匹配以及字符组；
"     \M仅使用^$来完成整行匹配或特定开头、结尾。
" 其他注意事项：
"     1. 由于反斜杠\肩负标示转义序列开始的特殊使命，在4种选项下\字符本身都要用\\表示。
"     2. 字母、数字、下划线开始的字符序列总表示字符本身，而由\开始后接字母、数字、
"        下划线字符序列，不管该转义序列有无特殊含义（如\d表示数字0-9，\y则仅表示字符y），
"        在4种选项下均具有相同的写法，也始终和正则表达式保持一致。
"     3. 除字母、数字、下划线和空格以外的字符（假设其为$）则因选项而异：若某选项下
"        默认它具有特殊含义，则$直接表示特殊含义，\$表示$字符本身；若某选项下默认它
"        没有特殊含义，则$表示$字符本身，\$表示特殊含义（也是$在正则表达式中的含义）。
"        当$在正则表达式中尚未拥有特殊含义时，则所谓特殊含义也因此而变为字符本身。
"     4. 如果某字符用于模式的分隔符（搜索分隔符有/和?两种，:s :g :v命令则可自定义
"        除\"|之外的其他单个字符作为模式分隔符，默认为/），则不管它在VIM正则表达式中
"        是否拥有特殊含义，都无法再用该字符表示正则特殊含义，因为它的第一特殊含义已
"        变为更为优先的模式分隔符，跟在\后则表示该字符本身（总得让每个选项下每个字符
"        本身能得以表达）。比如：以?开始的搜索，\?表示问号本身，再出现直接的?表示搜索
"        模式结束，表示0次或1次的量词已无从表达。使用/则不会出现这个问题，因为正则表达式
"        中/的特殊含义也是分隔符，因此推荐总是使用/作为模式分隔符，只在不想用正则的情况下，
"        待匹配模式中常出现/字符本身时，才推荐换用其他分隔符。
"     5. 当使用具有正则表达式意义的元字符括号时，在需要转义的选项下，开始括号([{必须
"        前加\，结束括号中，)必须前加\，]必须前不加\（\]专门在字符组中表示]字符），}则
"        可在前面加或不加\。

set magic  " 设置魔术



""""""""""""""""""""""""""""
" 折叠
""""""""""""""""""""""""""""
set foldenable    " 开始折叠
" 启用手工折叠  在可视化模式下，使用命令:zf，将折叠选中的文本。通过组合使用移动
" 命令，可以折叠指定的行。例如：使用zf70j命令，将折叠光标之后的70行；使用5zF命令，
" 将当前行及随后4行折叠起来；使用zf7G命令，将当前行至全文第7行折叠起来。
" 我们也可以使用以下命令，折叠括号（比如()、[]、{}、><等）包围的区域：zfa(Vim并不会
" 自动记忆手工折叠。但你可以使用以下命令，来保存当前的折叠状态：  :mkview
" 在下次打开文档时，使用以下命令，来载入记忆的折叠信息：  :loadview
" 可以使用以下命令，查看关于手工折叠的帮助信息：  :help fold-manual
set foldmethod=manual
" 启用缩进折叠  所有文本将按照（选项shiftwidth 定义的）缩进层次自动折叠。使用zm命令，
" 可以手动折叠缩进；而利用zr命令，则可以打开折叠的缩进。
" 使用以下命令，将可以根据指定的级别折叠缩进：  :set foldlevel=1
" 可以使用以下命令，查看关于缩进折叠的帮助信息：  :help fold-indent
set foldmethod=indent
" 启用语法折叠  所有文本将按照语法结构自动折叠。可以使用以下命令，查看关于语法折叠的
" 帮助信息：  :help fold-syntax
set foldmethod=syntax
" 启用标记折叠  所有文本将按照特定标记（默认为{{{和}}}）自动折叠。可以使用以下命令，
" 查看关于标记折叠的帮助信息：  :help fold-marker
set foldmethod=marker
" 将在屏幕左侧显示一个折叠标识列，分别用“-”和“+”而表示打开和关闭的折叠。其中，N是
" 一个0-12的整数，用于指定显示的宽度。使用以下命令，可以查看关于折叠的帮助信息：
" :help folding
set foldcolumn=5
" za 打开/关闭当前的折叠
" zc 关闭当前打开的折叠
" zo 打开当前折叠
" zm 关闭所有折叠
" zM 关闭所有折叠及其嵌套的折叠
" zr 打开所有折叠
" zR 打开所有折叠及其嵌套的折叠
" zd 删除当前折叠
" zE 删除所有折叠
" zj 移动至下一个折叠
" zk 移动至上一个折叠
" zn 禁用折叠
" zN 启用折叠

""""""""""""""""""""""""""""
" 字符编码
""""""""""""""""""""""""""""
" Vim 有四个跟字符编码方式有关的选项，encoding、fileencoding、fileencodings、
" termencoding 它们的意义如下:
"     * encoding: Vim 内部使用的字符编码方式，包括 Vim 的 buffer (缓冲区)、菜单文本、
"                 消息文本等。默认是根据你的locale选择.用户手册上建议只在 .vimrc 中
"                 改变它的值，
"                 事实上似乎也只有在.vimrc 中改变它的值才有意义。你可以用另外一种
"                 编码来编辑和保存文件，如你的vim的encoding为utf-8,所编辑的文件采用
"                 cp936编码,vim会自动将读入的文件转成utf-8(vim的能读懂的方式），而当
"                 你写入文件时,又会自动转回成cp936（文件的保存编码).
"     * fileencoding: Vim 中当前编辑的文件的字符编码方式，Vim 保存文件时也会将文件
"                     保存为这种字符编码方式 (不管是否新文件都如此)。
"     * fileencodings: Vim自动探测fileencoding的顺序列表， 启动时会按照它所列出的字符
"                      编码方式逐一探测即将打开的文件的字符编码方式，并且将 fileencoding
"                      设置为最终探测到的字符编码方式。
"                      因此最好将Unicode 编码方式放到这个列表的最前面，将拉丁语系
"                      编码方式 latin1 放到最后面。
"     * termencoding: Vim 所工作的终端 (或者 Windows 的 Console 窗口) 的字符编码方式。
"                     如果vim所在的term与vim编码相同，则无需设置。如其不然，你可以用vim的
"                     termencoding选项
"                     将自动转换成term的编码.这个选项在 Windows 下对我们常用的 GUI 模式的
"                     gVim 无效，而对 Console 模式的Vim 而言就是 Windows 控制台的代码页，
"                     并且通常我们不需要改变它。
" 解释完了这一堆容易让新手犯糊涂的参数，我们来看看 Vim 的多字符编码方式支持是如何工作的。
"     1. Vim 启动，根据 .vimrc 中设置的 encoding 的值来设置 buffer、菜单文本、消息文
"        的字符编码方式。
"     2. 读取需要编辑的文件，根据 fileencodings 中列出的字符编码方式逐一探测该文件
"        编码方式。并设置 fileencoding 为探测到的，看起来是正确的 (注1) 字符编码方式。
"     3. 对比 fileencoding 和 encoding 的值，若不同则调用 iconv 将文件内容转换为encoding
"        所描述的字符编码方式，并且把转换后的内容放到为此文件开辟的 buffer 里，此时我们就
"        可以开始编辑这个文件了。注意，完成这一步动作需要调用外部的 iconv.dll，你需要保证
"        这个文件存在于 $VIMRUNTIME 或者其他列在 PATH 环境变量中的目录里。
"     4. 编辑完成后保存文件时，再次对比 fileencoding 和 encoding 的值。若不同，再次调用
"        iconv 将即将保存的 buffer 中的文本转换为 fileencoding 所描述的字符编码方式，并保存
"        到指定的文件中。
"        同样，这需要调用 iconv.dll由于 Unicode 能够包含几乎所有的语言的字符，而且 Unicode
"        的 UTF-8 编码方式又是非常具有性价比的编码方式 (空间消耗比 UCS-2 小)，因此建议
"        encoding 的值设置为utf-8。
"        这么做的另一个理由是 encoding 设置为 utf-8 时，Vim 自动探测文件的编码方式会更
"        准确 (或许这个理由才是主要的 ;)。我们在中文 Windows 里编辑的文件，为了兼顾与其他
"        软件的兼容性，文件编码还是设置为 GB2312/GBK 比较合适，因此 fileencoding 建议设置为
"        chinese (chinese 是个别名，在 Unix 里表示 gb2312，在 Windows 里表示cp936，也就是
"        GBK 的代码页)。
" 对于fedora来说，vim的设置一般放在/etc/vimrc文件中，不过，建议不要修改它。可以
" 修改~/.vimrc文件（默认不存在，可以自己新建一个），写入所希望的设置。
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8

""""""""""""""""""""""""""""
" 文件侦测
""""""""""""""""""""""""""""
" vim中执行:filetype查看Vim的文件类型检测功能是否已打开；:set filetype查看当前文件
" 是什么类型；:set filetype=HTML设置文件类型为HTML；
" filetype的默认属性：detection:ON plugin:OFF indent:OFF
" detection：默认情况vim会对文件检测文件类型，也就是你看到的'detection:ON'，如需
"            关闭:filetype off。
"            还有一种方式就是在文件内容中指定，Vim会从文件的头几行自动扫描文件是否
"            有声明文件类型的代码，如在文件的首行加入 //vim: filetype=HTML，当作注释
"            写入，以致于不影响文件的编译，这样Vim不通过文件名也能检测出文件是什么类型
" plugin：当plugin状态为"ON"时，那么就会在Vim的运行时环境目录下加载该类型相关的插件。
"         比如为了让Vim更好的支持Html编程，就需要下载一些Html相关的插件。vim中执行
"         :filetype plugin on
" indent：不同类型文件有不同的方式，比如Python要求使用4个空格作为缩进，而Html使用
"         2个空格作为缩进，那么indent就可以为不同文件类型选择合适的缩进方式。
"         你可以在Vim的安装目录的indent目录下看到定义了很多缩进相关的脚本。vim中
"         执行 :filetype indent on。
" 以上三个参数，可以写成一行filetype plugin indent on在_vimrc文件中写入。

filetype on " 侦测文件类型
filetype plugin on  " 载入文件类型插件
filetype indent on  " 为特定文件类型载入相关缩进文件

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缩进
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim使用自动对齐，也就是把当前行的对起格式应用到下一行
set autoindent
" cindent Vim可以很好的识别出C和Java等结构化程序设计语言，并且能用C语言的缩进格式
" 来处理程序的缩进结构。
set cindent
" smartindent 在这种缩进模式中，每一行都和前一行有相同的缩进量，同时这种缩进形式能
" 正确的识别出花括号，当遇到右花括号（}），则取消缩进形式。此外还增加了识别C语言
" 关键字的功能。如果一行是以#开头的，那么这种格式将会被特殊对待而不采用缩进格式。
set smartindent
set tabstop=4  "设置tab键为4个空格宽度
" 设置当行之间交错时缩进的宽度（即换行时的缩进），这里的缩进宽度会尽可能多的使用
" Tab（这里的tab宽度使用 tabstop 设定的值），余下的宽度使用空格。
" 例如：tabstop设置为4,shiftwidth设置为6,那么换行之后就会缩进一个tab（4字节宽度）
" 和两个空格，共6字节。这里建议设置的值与tabstop一致。
set shiftwidth=4
set expandtab  " 将Tab转换成空格
" set noexpandtab " 不要用空格代替制表符
" 这里设置的是按一下Tab键字节宽度，类似与shiftwidth，softtabstop会尽可能取更多的tab，
" 剩下的用空格表示
set softtabstop=4
" set textwidth=5  " 达到指定字符宽度会自动换行，表现不是很稳定，不知道什么原因
"
" 对于已保存的文件，可以使用下面的方法进行空格和TAB的替换：
" TAB替换为空格：
"   :set ts=4
"   :set expandtab
"   :%retab!
" 空格替换为TAB：
"   :set ts=4
"   :set noexpandtab
"   :%retab!
" 加!是用于处理非空白字符之后的TAB，即所有的TAB，若不加!，则只处理行首的TAB。

map <F12> :call SwitchTab()<CR>
func! SwitchTab()
    if ( &expandtab == 0 )
        echo "switch tab to space, tab=4"
        set tabstop=4       " tab键空格宽度
        set softtabstop=4   " 在插入模式下按Tab键，实际插入的tab数和空格数
        set shiftwidth=4    " 在自动缩进或手动缩进模式下按Tab键，实际插入的tab数和空格数
        set expandtab       " 用空格代替tab
        set textwidth=0
    else
        echo "keep tab as tab, tab=4"
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set noexpandtab
        set textwidth=80
    endif
endfunc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","  " 如果mapleader变量没有设置，则用默认的反斜杠代替
nmap <leader>w :w!<cr>  " 根据mapleader的值，这条指令的快捷键为 ,w
nmap <leader>f :find<cr>

" 窗口快捷方式
map <c-h> <c-w>h
map <c-l> <c-w>l
map <c-j> <c-w>j
map <c-k> <c-w>k
" map <c-n> <c-w>n
" map <c-w> <c-w>w
" map <c-c> <c-w>c
map <leader>q :q<cr>
" map <c-o> <c-w>o

" 取消高亮快捷键
nnoremap <Leader>h :noh<CR>
" 进入命令行
nnoremap <Leader>sh :shell<CR>


" buffer 快捷方式  bNext  badd  ball  bdelete  behave  belowright  bfirst  blast
" bmodified  bnext  botright  bprevious
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bb :bp<CR>
nnoremap <Leader>bs :b#<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bc :bwipe<CR>


" 标签页快捷方式
nnoremap <Leader>tN :tabnew<CR>
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprevious<CR>
nnoremap <Leader>tc :tabclose<CR>
" 关闭其他 tab
nnoremap <Leader>to :tabonly<CR>
" 新建tab并编辑文件 :tabedit {file}
nnoremap <Leader>te :tabedit

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
" map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行
nnoremap <F2> :g/^\s*$/d<CR>
"比较文件
nnoremap <C-F2> :vert diffsplit
"新建标签
map <M-F2> :tabnew<CR>
"列出当前目录文件
map <F3> :tabnew .<CR>
"打开树状文件目录
map <C-F3> \be


func! IsFileExists(filename)
    " if filereadable(a:filename)
    "     exec "!echo file ".shellescape(expand('%:p:h').'/'.a:filename)." exist"
    " else
    "     exec "!echo file ".shellescape(expand('%:p:h').'/'.a:filename)." not exist"
    " endif

    return filereadable(a:filename)
endfunc

func! IsInGitRepo()
    let git_status = system('git rev-parse --is-inside-work-tree 2>&1')
    " v:shell_error 是一个特殊的变量，它用于存储最后一个 system() 函数调用的退出状态
    return v:shell_error == 0
endfunc

func! CheckGitRootFile(filename)
    let result = 0
    let old_dir = getcwd()
    " exec "!echo old_dir is ".old_dir
    " exec "!echo filename ".a:filename

    if IsInGitRepo()
        cd `git rev-parse --show-toplevel`
        " 在 Vim 脚本中，函数参数使用 a: 前缀来引用。这是 Vim 脚本的一个特性，
        " 用于区分函数参数和局部变量。
        if IsFileExists(a:filename)
            let result = 1
        endif
    endif

    exec "cd ".old_dir
    " let cur_dir = getcwd()
    " exec "!echo cur_dir is ".cur_dir
    return result
endfunc

func! ExecGitRootTool(filename)
    let old_dir = getcwd()
    " exec "!echo old_dir is ".old_dir
    " exec "!echo filename ".a:filename

    if IsInGitRepo()
        cd `git rev-parse --show-toplevel`
        " 在 Vim 脚本中，函数参数使用 a: 前缀来引用。这是 Vim 脚本的一个特性，
        " 用于区分函数参数和局部变量。
        if IsFileExists(a:filename)
            exec "!bash ".a:filename
        endif
    endif

    exec "cd ".old_dir
    " let cur_dir = getcwd()
    " exec "!echo cur_dir is ".cur_dir
endfunc

"C，C++ run
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    if filereadable(bufname('%'))
        exec "w"
    endif

    if IsFileExists(".prjBuild.sh")
        exec "!bash ./.prjBuild.sh"
    elseif IsFileExists("prjBuild.sh")
        exec "!bash ./prjBuild.sh"
    elseif CheckGitRootFile(".prjBuild.sh")
        call ExecGitRootTool(".prjBuild.sh")
    elseif CheckGitRootFile("prjBuild.sh")
        call ExecGitRootTool("prjBuild.sh")
    else
        if &filetype == 'c'
            exec "!gcc % -o %< -Wall -Wextra && ./%<"
        elseif &filetype == 'cpp'
            exec "!g++ % -o %< -Wall -Wextra && ./%<"
        elseif &filetype == 'java'
            exec "!javac %"
            exec "!java %<"
        elseif &filetype == 'python'
            :!python ./%
        elseif &filetype == 'sh'
            :!./%
        endif
        " if IsInGitRepo()
        "     " echomsg 与 echo 类似
        "     echo "If build prj, Please check .prjBuild.sh/prjBuild.sh in git root dir"
        " endif
    endif
endfunc
"C,C++ debug
map <F6> :call CompileRunGdb()<CR>
func! CompileRunGdb()
    if filereadable(bufname('%'))
        exec "w"
    endif

    if IsFileExists(".prjDebug.sh")
        exec "!bash ./.prjDebug.sh"
    elseif IsFileExists("prjDebug.sh")
        exec "!bash ./prjDebug.sh"
    elseif CheckGitRootFile(".prjDebug.sh")
        call ExecGitRootTool(".prjDebug.sh")
    elseif CheckGitRootFile("prjDebug.sh")
        call ExecGitRootTool("prjDebug.sh")
    else
        if &filetype == 'c'
            if has('mac')
                exec "!gcc % -g -o %< -Wall -Wextra && lldb ./%<"
            else
                exec "!gcc % -g -o %< -Wall -Wextra && gdb --command=debug.gdb ./%<"
            endif
        elseif &filetype == 'cpp'
            if has('mac')
                exec "!g++ % -g -o %< -Wall -Wextra && lldb ./%<"
            else
                exec "!g++ % -g -o %< -Wall -Wextra && gdb --command=debug.gdb ./%<"
            endif
        elseif &filetype == 'python'
            exec "!python -m pdb ./%"
        endif
        " if IsInGitRepo()
        "     " echomsg 与 echo 类似
        "     echo "If build prj, Please check .prjDebug.sh/prjDebug.sh in git root dir"
        " endif
    endif
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新文件标题
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.py,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.hpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()"
"定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!".exepath("bash"))
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Author: LiHongjin")
        call append(line(".")+3, "\# mail: 872648180@qq.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")
    elseif &filetype == 'python'
        call setline(1,"\#!".exepath("python"))
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Author: LiHongjin")
        call append(line(".")+3, "\# mail: 872648180@qq.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: LiHongjin")
        call append(line(".")+2, "    > Mail: 872648180@qq.com")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        " reference: https://segmentfault.com/a/1190000017798731 (VIM Script /VIML 脚本语言入门)
        " :echo @%                |" directory/name of file
        " :echo expand('%:p')     |" full path "PATH"
        " :echo expand('%:p:h')   |" directory containing file "HEAD"
        " :echo expand('%:t')     |" full name of file "TAIL"
        " :echo expand('%:t:r')   |" Only name of file "ROOT"
        " :echo expand('%:e')     |" Only extension of file "EXTENSION"
        " reference: https://learnvimscriptthehardway.stevelosh.com/chapters/27.html (Learn Vimscript the Hard Way)
        " :echom strlen("foo")
        " :echom len("foo")
        " :echo split("one two three")
        " :echo split("one,two,three", ",")
        " :echo join(["foo", "bar"], "...")
        " :echo join(split("foo bar"), ";")
        " :echom tolower("Foo")
        " :echom toupper("Foo")
        "

        if expand('%:e') == 'cpp'
            call append(line(".")+6, "#include <iostream>")
            call append(line(".")+7, "using namespace std;")
            call append(line(".")+8, "")
        elseif expand('%:e') == 'hpp'
            call append(line(".")+6, "#ifndef __".toupper(expand("%<")).expand("_HPP__"))
            call append(line(".")+7, "#define __".toupper(expand("%<")).expand("_HPP__"))
            call append(line(".")+8, "")
            call append(line(".")+9, "#endif /* ".toupper(expand("%<")).expand("_HPP__ */"))
        elseif expand('%:e') == 'h'
            call append(line(".")+6, "#ifndef __".toupper(expand("%<")).expand("_H__"))
            call append(line(".")+7, "#define __".toupper(expand("%<")).expand("_H__"))
            call append(line(".")+8, "")
            call append(line(".")+9, "#endif /* ".toupper(expand("%<")).expand("_H__ */"))
        endif
    elseif &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc
