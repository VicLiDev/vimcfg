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
    """
    Func:
        Display multiple variable values at breakpoints,
        and display is only triggered once
    Usage:
      <<method1>>
        bdp <file_name>:<line_number> <var1>,/x <var2>,<var3>...
      <<method2>>
        bdp <file_name>:<line_number> <var1>
        bdp <file_name>:<line_number> /x <var2>
        bdp <file_name>:<line_number> <var3>
    """

    def __init__(self):
        super().__init__("bdp", gdb.COMMAND_USER)
        self.bp_states = {}  # 存储每个断点的状态（是否已触发display）
        self.bp_locs = {}  # 存储已经设置过的断点位置

    def invoke(self, arg, from_tty):
        # 解析命令行输入
        # 字符串 arg 按照空白字符（默认空格）分割为最多两个部分，多个空格的话按照
        # 第一个空格分割
        args = arg.split(maxsplit=1)
        if len(args) != 2:
            print("Usage:")
            print("  <<method1>>")
            print("    bdp <file_name>:<line_number> <var1>,/x <var2>,<var3>...")
            print("  <<method2>>")
            print("    bdp <file_name>:<line_number> <var1>")
            print("    bdp <file_name>:<line_number> /x <var2>")
            print("    bdp <file_name>:<line_number> <var3>")
            return

        bp_user_loc = args[0]  # 断点位置
        dp_list = args[1]  # 多个要显示的变量

        # 检查该断点位置是否已经设置过
        # if bp_user_loc not in self.bp_locs:
        if bp_user_loc not in [v[2] for v in self.bp_locs.values()]:
            # 设置断点
            try:
                # 在指定的文件和行号上设置断点
                bp = gdb.Breakpoint(bp_user_loc)
                print(f"Set breakpoint at {bp.location}, Will display {dp_list}.")
                # 在字典中初始化该断点的状态
                # 初始化 display_triggered 为 False
                self.bp_states[bp.location] = False
                # 记录该断点的位置和 display 表达式
                self.bp_locs[bp.location] = (bp, dp_list, bp_user_loc)

                # 将 on_stop 事件绑定到 GDB 的 stop 事件
                # on_stop 会在 GDB 调试会话中每次程序停止时被调用。程序停止可以是
                # 由多种事件引起的，比如触发断点、程序结束、异常等。
                gdb.events.stop.connect(self.on_stop)

            except gdb.error as e:
                print(f"Error: {str(e)}")
        else:
            bp = gdb.Breakpoint
            new_dp_list = ""
            exist_user_loc = ""
            for key in self.bp_locs.keys():
                if bp_user_loc == self.bp_locs[key][2]:
                    bp, exist_dp_list, exist_user_loc = self.bp_locs[key]
                    # 合并新的 display 表达式
                    if self.bp_states[bp.location] == False:
                        # 将两个由逗号分隔的字符串合并，并去除其中的重复项，结果是一个包含所有唯一项的集合
                        new_dp_list = set(exist_dp_list.split(',') + dp_list.split(','))
                        # 将去重并排序后的集合转换回一个由逗号分隔的字符串
                        new_dp_list = ",".join(sorted(new_dp_list))  # 保持顺序
                        print(f"Breakpoint {bp_user_loc} exists. New display list: {new_dp_list}")
                    else:
                        new_dp_list = set(dp_list.split(','))
                        new_dp_list = ",".join(sorted(new_dp_list))  # 保持顺序
                        print(f"Breakpoint {bp_user_loc} exists. New display list: {new_dp_list}")
                    self.bp_states[bp.location] = False
                    break

            # 更新断点位置和 display 表达式
            self.bp_locs[bp.location] = (bp, new_dp_list, exist_user_loc)


    def on_stop(self, event):
        """回调函数：处理 GDB 停止事件"""
        # # 获取当前停止的原因
        # if isinstance(event, gdb.BreakpointEvent):
        #     print("Stopped at a breakpoint.")
        # elif isinstance(event, gdb.SignalEvent):
        #     print(f"Stopped due to signal: {event.stop_signal}")
        # elif isinstance(event, gdb.StopEvent):
        #     # 如果是监视点事件
        #     if hasattr(event, 'watchpoint'):
        #         print(f"Stopped at a watchpoint: {event.watchpoint}")
        #     else:
        #         print("Stopped for an unknown reason.")

        # 检查是否是断点事件，并且断点是否为我们设置的
        if isinstance(event, gdb.BreakpointEvent):
            bp = event.breakpoint
            bp_user_loc = str(bp.location)  # 直接将 location 转换为字符串

            # 确认断点是否已经触发过 display
            if bp_user_loc in self.bp_locs:
                dp_list = self.bp_locs[bp_user_loc][1]
                if not self.bp_states.get(bp.location, False):  # 如果没有触发 display
                    # 断点触发时将多个表达式拆分并单独显示
                    for dp_list in dp_list.split(','):
                        dp_list = dp_list.strip()  # 去掉空格
                        try:
                            gdb.execute(f"display {dp_list}")
                        except gdb.error as e:
                            print(f"Error: Couldn't evaluate list '{dp_list}': {str(e)}")
                    # 更新状态，表示 display 已经触发
                    self.bp_states[bp.location] = True

        return False  # 返回 False 继续执行程序

# 注册命令
BreakPointWithDisplay()
