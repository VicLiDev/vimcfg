-- nvim-treesitter.configs module has been removed in recent versions
-- Use vim.treesitter API directly

local parser_install = require("nvim-treesitter.install")
parser_install.prefer_git = false

-- Auto-install parsers
local parsers = { "python", "cpp", "lua", "vim", "json" }
for _, parser in ipairs(parsers) do
  if not pcall(vim.treesitter.language.inspect, parser) then
    vim.cmd("TSInstall " .. parser)
  end
end

-- Enable highlighting
vim.treesitter.language.register("vim", "vimdoc")
for _, lang in ipairs({ "help" }) do
  vim.treesitter.start(lang, false)  -- disable for help files
end

-- Enable treesitter-based highlighting for all filetypes with parsers
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
