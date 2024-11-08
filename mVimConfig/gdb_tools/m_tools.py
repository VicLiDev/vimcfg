#!/usr/bin/env python
#########################################################################
# File Name: m_tools.py
# Author: LiHongjin
# mail: 872648180@qq.com
# Created Time: Thu 07 Nov 2024 05:41:35 PM CST
#########################################################################

import gdb
import re

class PrintLocals(gdb.Command):
    """Print all local variables in the current frame."""

    def __init__(self):
        super(PrintLocals, self).__init__("prn_locs", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        frame = gdb.selected_frame()  # 获取当前堆栈帧
        block = frame.block()  # 获取当前帧的符号表

        # 打印当前帧的函数名
        print("Local variables in function: %s" % frame.name())

        while block:
            # 遍历符号块中的所有局部变量
            for symbol in block:
                # 直接检查是否为变量，并且不是函数参数
                if symbol.is_variable and not symbol.is_argument:
                    try:
                        value = frame.read_var(symbol)  # 读取变量的值
                        print("%s = %s" % (symbol.name, value))
                    except gdb.error as e:
                        print(f"Error reading {symbol.name}: {e}")
            block = block.superblock  # 切换到上一层符号块

# Instantiate the command
PrintLocals()


class DumpRegistersCommand(gdb.Command):
    """A custom GDB command to dump register values."""

    def __init__(self):
        super(DumpRegistersCommand, self).__init__("dump_regs", gdb.COMMAND_DATA)

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


class FilterThreadsByLibrary(gdb.Command):
    """Filter threads by the library used in the current stack frame across all threads."""

    def __init__(self):
        super(FilterThreadsByLibrary, self).__init__("filter_thd_by_lib", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        # 获取目标库名，用户传入的参数
        library_name = arg.strip()
        if not library_name:
            print("Usage: filter_thd_by_lib <library_name>")
            return

        # 获取当前进程的所有共享库信息，包括库的加载地址范围
        shared_libs = gdb.execute("info sharedlibrary", to_string=True)

        # 解析每个库的名称和加载地址范围
        library_ranges = {}
        for line in shared_libs.splitlines():
            # 括号括起来的算是一个组，因此这里可以捕获四个组
            match = re.match(r"\s*0x([0-9a-fA-F]+)\s+0x([0-9a-fA-F]+).*target:(/.*/(.*\.so.*))", line)
            if match:
                start_addr = match.group(1)  # 捕获第1组：起始地址
                end_addr = match.group(2)    # 捕获第2组：结束地址
                lib_path = match.group(3)    # 捕获第3组：库路径
                lib_name = match.group(4)    # 捕获第4组：库名
                library_ranges[lib_name] = (start_addr, end_addr)

        # 检查指定库是否存在
        if library_name not in library_ranges:
            print(f"Library '{library_name}' not found in the loaded shared libraries.")
            return

        # 获取当前进程的所有线程
        inferior = gdb.selected_inferior()
        threads = inferior.threads()

        # 遍历所有线程
        for thread in threads:
            thread.switch()  # 切换到该线程

            # print(f"Checking stack frames for Thread {thread.num}")
            # 获取当前线程的调用栈
            frame = gdb.selected_frame()
            frame_number = 0

            # 遍历当前线程的堆栈帧
            while frame is not None:
                frame_number += 1
                # 获取当前帧的程序计数器 (PC)
                pc = frame.pc()

                # 检查栈帧的PC是否在目标库的地址范围内
                start_addr, end_addr = library_ranges[library_name]
                if int(start_addr, 16) <= pc <= int(end_addr, 16):
                    print(f"  Thread {thread.num}, {thread.name}: Frame {frame_number} at {frame.function()} in {library_name} at {hex(pc)}")

                # 切换到上一层栈帧
                try:
                    frame = frame.older()
                except gdb.error:
                    break

# 注册命令
FilterThreadsByLibrary()


class BreakPointWithDisplay(gdb.Command):
    """一个在函数调用时自动显示多个变量值的 GDB 命令，确保 display 只触发一次"""

    def __init__(self):
        super().__init__("b_with_dp", gdb.COMMAND_USER)
        self.breakpoint_states = {}  # 存储每个断点的状态

    def invoke(self, arg, from_tty):
        # 解析命令行输入
        args = arg.split(maxsplit=1)
        if len(args) != 2:
            print("Usage: b_with_dp <file_name>:<line_number> <variable1>,<variable2>,...")
            return

        breakpoint_loc = args[0]  # 断点位置
        display_exprs = args[1]  # 多个要显示的变量

        # 设置断点
        try:
            # 在指定的文件和行号上设置断点
            bp = gdb.Breakpoint(breakpoint_loc)
            print(f"Set breakpoint at {breakpoint_loc}, and will display {display_exprs} once.")

            # 在字典中初始化该断点的状态
            self.breakpoint_states[bp] = False  # 初始化 display_triggered 为 False

            # 定义一个回调函数来处理断点触发
            def on_stop(event):
                if isinstance(event, gdb.BreakpointEvent) and event.breakpoint == bp:
                    if not self.breakpoint_states[bp]:  # 检查该断点是否已触发 display
                        # 断点触发时将多个表达式拆分并单独显示
                        for expr in display_exprs.split(','):
                            gdb.execute(f"display {expr.strip()}")  # 为每个表达式单独执行 display
                        self.breakpoint_states[bp] = True  # 标记 display 已经触发
                    return False  # 返回 False 继续执行程序

            # 绑定 stop 事件
            gdb.events.stop.connect(on_stop)
        except gdb.error as e:
            print(f"Error: {str(e)}")

# 注册命令
BreakPointWithDisplay()
