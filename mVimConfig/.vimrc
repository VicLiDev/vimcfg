" ========================================================================================== Vim Tutorials
"
" ----------------------------------------- Common settings ----------------------------------------- 
"
" ----------------------------------------- key map ----------------------------------------- 
"  https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
"
"  **** general ****
"
"  正常模式（即命令模式或普通模式）、插入模式、命令行模式、可视模式、选择模式、操作员待定模式
"
" The general syntax of a map command is:
"
" {cmd} {attr} {lhs} {rhs}
" 
" where
" {cmd}  is one of ':map', ':map!', ':nmap', ':vmap', ':imap',
"        ':cmap', ':smap', ':xmap', ':omap', ':lmap', etc.
" {attr} is optional and one or more of the following: <buffer>, <silent>,
"        <expr> <script>, <unique> and <special>.
"        More than one attribute can be specified to a map.
" {lhs}  left hand side, is a sequence of one or more keys that you will use
"        in your new shortcut.
" {rhs}  right hand side, is the sequence of keys that the {lhs} shortcut keys
"        will execute when entered.
"
"  **** create maps ****
" 创建映射的步骤：
" 第一步是确定映射将要运行的键的顺序。 当您调用映射时，Vim会执行键序列，就像您从键盘上输入它一样。 
" 第二步是确定映射应在其中工作的编辑模式（插入模式，可视模式，命令行模式，普通模式等）。与其创建适用于所有模式的映射，不如定义仅适用于选定模式的映射。
" 第三步是找到可用于调用映射的未使用键序列。您可以使用单个键或键序列来调用映射。
"
" 将映射命令添加到文件时，命令前可以不加':'字符。
"
"  **** display maps ****
"
" 您可以使用以下命令（不带任何参数）显示现有键映射的列表：
" :map  显示普通模式、可视模式、选择模式、操作员待定模式的映射
" :map! 显示插入模式、命令行模式的映射
" :nmap-显示普通模式映射
" :imap-显示插入模式映射
" :vmap-显示可视、选择模式映射
" :smap-显示选择模式映射
" :xmap-显示可视模式映射
" :cmap-显示命令行模式映射
" :omap-显示操作员待定模式映射
"
"  **** remove a key map ****
"
" 要永久删除地图，您首先需要使用'：verbose map {lhs}'命令（用映射的键序列替换{lhs}）来定位它的定义位置。
" 如果在.vimrc或_vimrc文件或vimfiles或.vim目录中的文件之一中定义了映射，则可以编辑该文件以删除该映射。
" 另一种方法是使用'：unmap'和'：unmap！'。 命令删除地图。 例如，要删除<F8>键的映射，可以使用以下命令：
"
" 可以使用特定于模式的unmap命令删除特定于模式的映射。 下面列出了特定于模式的unmap命令：
" nunmap - Unmap a normal mode map
" vunmap - Unmap a visual and select mode map
" xunmap - Unmap a visual mode map
" sunmap - Unmap a select mode map
" iunmap - Unmap an insert and replace mode map
" cunmap - Unmap a command-line mode map
" ounmap - Unmap an operator pending mode map
"
" 要清除特定模式下的所有映射，可以使用'：mapclear'命令。 特定于模式的map clear命令如下所示：
" mapclear  - Clear all normal, visual, select and operating pending mode maps
" mapclear! - Clear all insert and command-line mode maps
" nmapclear - Clear all normal mode maps
" vmapclear - Clear all visual and select mode maps
" xmapclear - Clear all visual mode maps
" smapclear - Clear all select mode maps
" imapclear - Clear all insert mode maps
" cmapclear - Clear all command-line mode maps
" omapclear - Clear all operating pending mode maps
"
" **** Mode-specific maps ****
"
" Vim支持创建仅在特定编辑模式下起作用的键盘映射。 您可以创建仅在正常，插入，可视，选择，命令和操作员待定模式下起作用的键盘映射。 下表列出了各种映射命令及其相应的编辑模式：
" Commands                        Mode
" --------                        ----
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" xmap, xnoremap, xunmap          Visual mode
" smap, snoremap, sunmap          Select mode
" cmap, cnoremap, cunmap          Command-line mode
" omap, onoremap, ounmap          Operator pending mode
"
"
" **** Mapping mouse events ****
" <LeftMouse>     - Left mouse button press
" <RightMouse>    - Right mouse button press
" <MiddleMouse>   - Middle mouse button press
" <LeftRelease>   - Left mouse button release
" <RightRelease>  - Right mouse button release
" <MiddleRelease> - Middle mouse button release
" <LeftDrag>      - Mouse drag while Left mouse button is pressed
" <RightDrag>     - Mouse drag while Right mouse button is pressed
" <MiddleDrag>    - Mouse drag while Middle mouse button is pressed
" <2-LeftMouse>   - Left mouse button double-click
" <2-RightMouse>  - Right mouse button double-click
" <3-LeftMouse>   - Left mouse button triple-click
" <3-RightMouse>  - Right mouse button triple-click
" <4-LeftMouse>   - Left mouse button quadruple-click
" <4-RightMouse>  - Right mouse button quadruple-click
" <X1Mouse>       - X1 button press
" <X2Mouse>       - X2 button press
" <X1Release>     - X1 button release
" <X2Release>     - X2 button release
" <X1Drag>        - Mouse drag while X1 button is pressed
" <X2Drag>        - Mouse drag while X2 button is pressed
"
" example: :nnoremap <2-LeftMouse> :exe "tag ". expand("<cword>")<CR>
"
" ----------------------------------------- Plug-in installation and configuration ----------------------------------------- 
"
" ----------------------------------------- Custom function (vimscript) ----------------------------------------- 

" ========================================================================================== Vim Tutorials end

" ========================================================================================== Load Configs
" 文件名后缀没有严格要求
" map <F2> :echo "Hello World! This is map test! "<CR>
" set runtimepath+=~/.vim_l
source ~/.cus_vimrcs/commoncfg.vim
source ~/.cus_vimrcs/plugins.vim

" source ~/.vim_runtime/vimrcs/filetypes.vim
" source ~/.vim_runtime/vimrcs/plugins_config.vim
" source ~/.vim_runtime/vimrcs/extended.vim
" 
" try
" source ~/.vim_runtime/my_configs.vim
" catch
" endtry
