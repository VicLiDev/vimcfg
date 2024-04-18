-- 启用实验性 Lua 模块加载器
vim.loader.enable()

-- vim.api.<func>([...]) vim.api使用参数 {...} 调用 Nvim API 函数 {func}
local api = vim.api
-- 当前nvim的版本
local version = vim.version

-- check if we have the latest stable version of nvim
-- local expected_ver = "0.9.1"
-- local ev = version.parse(expected_ver)
-- local actual_ver = version()
-- 
-- if version.cmp(ev, actual_ver) ~= 0 then
--   local _ver = string.format("%s.%s.%s", actual_ver.major, actual_ver.minor, actual_ver.patch)
--   local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, _ver)
--   api.nvim_err_writeln(msg)
--   return
-- end

local core_conf_files = {
  "globals.lua", -- some global settings
  "options.vim", -- setting options in nvim
  "autocommands.vim", -- various autocommands
  "mappings.lua", -- all the user-defined mappings
  "plugins.vim", -- all the plugins installed and their configurations
  "colorschemes.lua", -- colorscheme settings
}

-- source all the core config files
for _, name in ipairs(core_conf_files) do
  local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
  -- ".." 用于连接字符串，如果是变量则使用值替换之后连接
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end


-- Mappings can be created using vim.keymap.set(). This function takes three
-- mandatory arguments:
--   {mode} is a string or a table of strings containing the mode prefix for
--          which the mapping will take effect. The prefixes are the ones
--          listed in :map-modes, or "!" for :map!, or empty string for :map.
--   {lhs} is a string with the key sequences that should trigger the mapping.
--   {rhs} is either a string with a Vim command or a Lua function that should
--         be executed when the {lhs} is entered. An empty string is equivalent
--         to <Nop>, which disables a key.
-- 几种模式的介绍
--     Normal Mode：也就是最一般的普通模式，默认进入vim之后，处于这种模式。
--     Visual Mode：一般译作可视模式，在这种模式下选定一些字符、行、多列。
--                  在普通模式下，可以按v进入。
--     Insert Mode：插入模式，其实就是指处在编辑输入的状态。普通模式下，可以按i进入。
--     Select Mode：选择模式。用鼠标拖选区域的时候，就进入了选择模式。和可视模式
--                  不同的是，在这个模式下，选择完了高亮区域后，敲任何按键就直接
--                  输入并替换选择的文本了。和windows下的编辑器选定编辑的效果一致。
--                  普通模式下，可以按gh进入。
--     Command-Line/Ex Mode：命令行模式和Ex模式。两者略有不同，普通模式下按冒号(:)
--                  进入Command-Line模式，可以输入各种命令，使用vim的各种强大功能。
--                  普通模式下按Q进入Ex模式，其实就是多行的Command-Line模式。
