local gs = require("gitsigns")

gs.setup {
  signs = {
    -- add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    -- change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    -- delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- changedelete = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },

    -- add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    -- change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    -- delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    -- topdelete    = { hl = 'GitSignsTopdelete', text = '‾', numhl = 'GitSignsTopdeleteNr', linehl = 'GitSignsTopdeleteLn' },
    -- changedelete = { hl = 'GitSignsChangedelete', text = '~', numhl = 'GitSignsChangedeleteNr', linehl = 'GitSignsChangedeleteLn' },

    -- add          = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    -- change       = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    -- delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    -- topdelete    = { hl = 'GitSignsTopdelete', text = '‾', numhl = 'GitSignsTopdeleteNr', linehl = 'GitSignsTopdeleteLn' },
    -- changedelete = { hl = 'GitSignsChangedelete', text = '│', numhl = 'GitSignsChangedeleteNr', linehl = 'GitSignsChangedeleteLn' },

    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '│' },
  },
  word_diff = true,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "previous hunk" })

    -- Actions
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line { full = true }
    end)
  end,
}

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = "*",
  callback = function()
    vim.cmd [[
      hi GitSignsChangeInline gui=reverse
      hi GitSignsAddInline gui=reverse
      hi GitSignsDeleteInline gui=reverse
    ]]
  end
})


-- 定义 GitSigns 高亮组
vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'DiffDelete' })
