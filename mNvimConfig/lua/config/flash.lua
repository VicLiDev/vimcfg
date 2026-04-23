local flash = require("flash")
local keymap = vim.keymap

flash.setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  modes = {
    char = {
      jump_labels = true,
    },
  },
})

-- Map f to flash.jump (replaces hop char2)
keymap.set({ "n", "x", "o" }, "f", function() flash.jump() end, {
  silent = true,
  desc = "Flash jump",
})

-- Map F to flash treesitter select
keymap.set({ "n", "x", "o" }, "F", function() flash.treesitter() end, {
  silent = true,
  desc = "Flash treesitter select",
})

-- Map t to flash.treesitter for operator-pending mode
keymap.set({ "o" }, "r", function() flash.treesitter() end, {
  silent = true,
  desc = "Flash treesitter (operator)",
})
