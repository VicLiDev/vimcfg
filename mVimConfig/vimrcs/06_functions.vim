" ── Custom Functions ─────────────────────────────────────

" ── 行尾空格清理 ──────────────────────────────────────
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

" ── 文件/Git 工具函数（编译运行辅助）───────────────────
function! IsFileExists(fname)

    return filereadable(a:fname)
endfunction

function! IsInGitRepo()
    call system('git rev-parse --is-inside-work-tree 2>/dev/null')
    return v:shell_error == 0
endfunction

function! CheckGitRootFile(root, file)
    if empty(a:root) || empty(a:file)
        return 0
    endif
    let l:path = a:root . '/' . a:file
    if isdirectory(l:path)
        return 1
    endif
    return IsFileExists(l:path)
endfunction

function! ExecGitRootTool(cmd, root)
    if empty(a:root) || empty(a:cmd)
        echo 'Error: root or cmd is empty'
        return -1
    endif
    execute '!cd ' . a:root . ' && ' . a:cmd
endfunction

" ── 编译运行 (F5) ──────────────────────────────────────
function! CompileRun()
    exec "w"
    let compilecmd = ""
    let excmd = ""

    " 优先级1: 当前目录的构建脚本
    if IsFileExists(".prjBuild.sh")
        exec "!bash ./.prjBuild.sh"
        return
    elseif IsFileExists("prjBuild.sh")
        exec "!bash ./prjBuild.sh"
        return
    endif

    if IsInGitRepo()
        " 优先级2: Git 项目根目录的构建脚本
        let l:git_root = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '\n', '', 'g')
        if CheckGitRootFile(l:git_root, '.prjBuild.sh')
            call ExecGitRootTool('bash .prjBuild.sh', l:git_root)
            return
        elseif CheckGitRootFile(l:git_root, 'prjBuild.sh')
            call ExecGitRootTool('bash prjBuild.sh', l:git_root)
            return
        endif

        " 优先级3: Git 项目构建系统 (CMake/Makefile/meson)
        if CheckGitRootFile(l:git_root, 'CMakeLists.txt')
            call ExecGitRootTool('cd build && cmake .. && make -j$(nproc)', l:git_root)
            return
        elseif CheckGitRootFile(l:git_root, 'Makefile')
            call ExecGitRootTool('make -j$(nproc)', l:git_root)
            return
        elseif CheckGitRootFile(l:git_root, 'meson.build')
            call ExecGitRootTool('ninja -C builddir', l:git_root)
            return
        endif
    endif

    " 优先级4: 单文件编译运行（按文件类型）
    if &filetype == 'c'
        let compilecmd = "!gcc -Wall -Wextra % -o %<"
        let excmd = "!time ./%<"
    elseif &filetype == 'cpp'
        let compilecmd = "!g++ -std=c++11 -Wall -Wextra % -o %<"
        let excmd = "!time ./%<"
    elseif &filetype == 'java'
        let compilecmd = "!javac %"
        let excmd = "!time java %<"
    elseif &filetype == 'sh'
        let excmd = "!time bash %"
    elseif &filetype == 'python'
        let excmd = "!time python3 %"
    elseif &filetype == 'html'
        let excmd = "!google-chrome % &"
    elseif &filetype == 'go'
        let compilecmd = "!go build -o %< %"
        let excmd = "!time ./%<"
    elseif &filetype == 'mksh'
        let excmd = "!time mksh %"
    elseif &filetype == 'lua'
        let excmd = "!time lua5.4 %"
    elseif &filetype == 'rust'
        let compilecmd = "!rustc % -o %<"
        let excmd = "!time ./%<"
    elseif &filetype == 'typescript'
        let excmd = "!tsc % && node %<"
    elseif &filetype == 'javascript'
        let excmd = "!node %"
    endif

    if compilecmd !=# ''
        silent exec compilecmd
    endif
    if excmd !=# ''
        exec excmd
    elseif compilecmd ==# ''
        echo 'No run command for current filetype.'
    endif
endfunction

" ── GDB 调试 (F6) ──────────────────────────────────────
function! CompileDbg()
    exec "w"

    " 优先级1: 当前目录的调试脚本
    if IsFileExists(".prjDebug.sh")
        exec "!bash ./.prjDebug.sh"
        return
    elseif IsFileExists("prjDebug.sh")
        exec "!bash ./prjDebug.sh"
        return
    endif

    " 优先级2: Git 项目根目录的调试脚本
    if IsInGitRepo()
        let l:git_root = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '\n', '', 'g')
        if CheckGitRootFile(l:git_root, '.prjDebug.sh')
            call ExecGitRootTool('bash .prjDebug.sh', l:git_root)
            return
        elseif CheckGitRootFile(l:git_root, 'prjDebug.sh')
            call ExecGitRootTool('bash prjDebug.sh', l:git_root)
            return
        endif
    endif

    " 优先级3: 单文件调试（按文件类型）
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
        exec "!python3 -m pdb %"
    elseif &filetype == 'sh'
        exec "!bash -x %"
    elseif &filetype == 'go'
        exec "!dlv debug %"
    elseif &filetype == 'rust'
        exec "!rust-gdb %<"
    endif
endfunction

" ── Tab/Space 切换 (F12) ───────────────────────────────
function! SwitchTab()
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
endfunction

" ── 新建文件模板 (SetTitle) ────────────────────────────
" 新建.c,.h,.sh,.py,.java文件，自动插入文件头
"定义函数SetTitle，自动插入文件头
function SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        " call setline(1,"\#!".exepath("bash"))
        " #!bash 当脚本被执行时，系统会尝试在固定的几个路径（通常是 /bin、/usr/bin、
        "        /usr/local/bin 等）中查找名为 bash 的可执行文件，如果 bash 可执行
        "        文件不在上述路径之一，或者它的位置因系统不同而有所变化，那么脚本
        "        可能无法在所有系统上正常执行。
        " #!env bash 使用了 env 程序来查找 bash 解释器。env 程序会在环境变量 PATH
        "        中列出的所有路径中搜索名为 bash 的可执行文件。这种方式的优势在于
        "        提高了脚本的便携性，因为它不依赖于 bash 解释器的固定位置。无论
        "        bash 安装在哪里，只要它在 PATH 环境变量中，env 就能找到它，这使得
        "        脚本更有可能在不同的系统和环境中成功执行。
        " 在现代的 Unix-like 系统中，推荐使用 #!/usr/bin/env bash，因为它更加灵活
        " 和可靠。然而，对于一些老的系统，可能需要使用 #!/bin/bash，因为它们可能
        " 不支持 env 的 shebang 行用法。
        call setline(1,"\#!/usr/bin/env bash")
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\# File Name: ".expand("%:t"))
        call append(line(".")+2, "\# Author: Hongjin Li")
        call append(line(".")+3, "\# mail: 872648180@qq.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")
    elseif &filetype == 'python'
        " call setline(1,"\#!".exepath("python"))
        call setline(1,"\#!/usr/bin/env python")
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\# File Name: ".expand("%:t"))
        call append(line(".")+2, "\# Author: Hongjin Li")
        call append(line(".")+3, "\# mail: 872648180@qq.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%:t"))
        call append(line(".")+1, "    > Author: Hongjin Li")
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
endfunction

" ── 快速插入日志 ──────────────────────────────────────
function InsertLog()
    call append(line("."),"printf(\"======> lhj add file:%s func:%s line:%d \\n\",")
    call append(line(".")+1,"__FILE__, __func__, __LINE__);")
endfunction
