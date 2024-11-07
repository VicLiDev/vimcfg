
GDB（GNU Debugger）提供了很多方式来定制和扩展其功能，包括通过脚本、插件以及命令
扩展。常见的扩展方式有三种：
* 通过 GDB 内置的脚本语言（Python）
* GDB 插件（C/C++ 扩展）
* GDB 的命令

下面是一些常见的编写 GDB 工具的方法。

# 使用 GDB 的 Python 脚本扩展

GDB 支持 Python 脚本来编写自定义工具和扩展。你可以通过 Python 脚本访问 GDB 的调试
功能，甚至实现复杂的调试逻辑。

## 步骤：
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

## Python 脚本常用功能：
- 获取当前堆栈帧：`gdb.selected_frame()`
- 获取寄存器值：`gdb.parse_and_eval('$eax')`
- 执行 GDB 命令：`gdb.execute('command')`
- 定义自定义命令：通过继承 `gdb.Command` 类实现

## Python脚本详细教程

### 确保 GDB 支持 Python
首先，确认你使用的 GDB 版本支持 Python。在终端输入以下命令检查：
```bash
gdb --version
```
输出中应该包含类似 `Python` 的字样，表示 GDB 编译时启用了 Python 支持。

### 在 GDB 中使用 Python

GDB 提供了一个 Python 解释器环境，可以直接在 GDB 中输入 Python 代码进行调试和扩展。

#### 直接在 GDB 中输入 Python 代码

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

### 编写 Python 脚本

可以将 Python 代码保存到脚本文件中，方便重用和管理。GDB 支持通过 `source` 命令
加载 Python 脚本。

在 GDB 中，脚本的文件名 不需要与自定义命令的名称一致。一个 Python 脚本中可以定义
多个自定义命令，它们完全可以使用不同的命令名。

#### 示例：创建一个简单的 Python 脚本

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

#### 说明：
- 我们定义了一个新的 GDB 命令 `dump_registers`，它将输出当前所有的寄存器值和堆栈跟踪信息。
- 使用 `gdb.selected_frame()` 获取当前堆栈帧，并使用 `frame.read_register()` 获取寄存器的值。
- 使用 `gdb.execute("backtrace")` 执行 GDB 的内置命令 `backtrace`，以打印堆栈信息。

#### 在 GDB 中加载 Python 脚本
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

### Python 与 GDB 内部数据结构交互
GDB 提供了非常丰富的 Python API，可以与调试器的各个部分进行交互。以下是一些常见的操作：

#### 获取当前堆栈帧
你可以通过 Python 脚本访问当前的堆栈帧和局部变量：
```python
frame = gdb.selected_frame()
print(frame.name())  # 打印当前函数名
for var in frame.block():
    print(var.name, var.value())  # 打印当前堆栈帧中的所有局部变量
```

#### 获取和设置寄存器值
你可以通过 Python 获取或设置寄存器的值：
```python
# 获取寄存器的值
eax_value = gdb.parse_and_eval('$eax')
print(f'EAX: {eax_value}')

# 设置寄存器的值
gdb.execute('set $eax = 0x12345678')
```

#### 获取和设置内存
你可以直接访问目标程序的内存，进行读写操作：
```python
# 读取内存
address = 0x601000
data = gdb.selected_inferior().read_memory(address, 4)
print(data)

# 写入内存
gdb.selected_inferior().write_memory(address, b'\x90\x90\x90\x90')  # 写入 NOP 指令
```

#### 调试控制

你可以通过 Python 脚本控制 GDB 调试过程，例如设置断点、步进、继续执行等：
```python
# 设置断点
gdb.execute('break main')

# 继续执行程序
gdb.execute('continue')

# 步进执行
gdb.execute('step')
```

### 创建交互式的 GDB 命令
你还可以创建交互式的命令，允许用户输入参数并在命令执行时进行处理。

#### 示例：带参数的自定义命令
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

### 调试脚本的调试和优化

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

### 常用的 GDB Python API
- `gdb.selected_frame()`：获取当前堆栈帧。
- `gdb.selected_inferior()`：获取当前调试目标。
- `gdb.parse_and_eval(expression)`：解析并计算表达式。
- `gdb.execute(command)`：执行 GDB 命令。
- `gdb.regs()`：获取当前可用的寄存器列表。
- `gdb.breakpoint(function_name)`：设置一个函数的断点。

### 保存和加载脚本
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

# 编写 GDB 插件（C/C++ 扩展）

除了使用 Python 脚本，GDB 还允许使用 C/C++ 编写插件，以实现更高效、更复杂的功能。

## 步骤：

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

## 插件常用功能：
- 通过 C/C++ 代码访问 GDB 的内部 API，如操作断点、堆栈、寄存器、内存等。
- 注册自定义的 GDB 命令。
- 实现复杂的调试功能，比如自动化检查、动态分析等。

# 使用 GDB 自定义命令和宏

你可以在 GDB 中定义自己的命令和宏，来自动化调试过程。

## 定义 GDB 命令：
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

## 定义 GDB 宏：
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

# 使用 GDB 的 TUI 模式
如果你需要开发一个具有图形界面的调试工具，可以使用 GDB 的 TUI（Text User Interface）
模式。通过 TUI 模式，你可以创建分屏的界面，显示源代码、寄存器、堆栈等信息。

## 启用 TUI 模式：
```bash
(gdb) tui enable
```
这会将 GDB 的界面切换为分屏模式，可以通过快捷键控制不同的视图。

# 其他调试功能扩展

- **自定义断点处理**：你可以为断点设置条件、命令或日志输出。例如：
  ```bash
  (gdb) break main if x == 42
  (gdb) break foo do printf("foo hit\n")
  ```

- **脚本化调试流程**：通过脚本自动化一些重复性操作，如在程序崩溃时自动收集堆栈
  跟踪信息、输出变量的值等。

# 总结：

编写自己的 GDB 工具可以通过多种方式实现，Python 脚本是最常见和简单的方式，可以
快速实现自定义命令和调试逻辑；而 C/C++ 插件则适用于需要更高性能或更复杂功能的
场景。通过自定义命令和宏，GDB 也能实现一定程度的自动化调试。如果你对 GDB 的内核
和扩展机制有深入了解，还可以编写更为复杂的插件来满足你的需求。
