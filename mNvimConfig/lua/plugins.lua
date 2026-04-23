-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local utils = require("utils")

-- check if firenvim is active
local function firenvim_not_active()
  return not vim.g.started_by_firenvim
end

require("lazy").setup({

  -- ============================================
  -- Completion
  -- ============================================
  { "onsails/lspkind-nvim", event = "VimEnter" },

  {
    "hrsh7th/nvim-cmp",
    dependencies = "lspkind-nvim",
    config = function() require("config.nvim-cmp") end,
  },

  -- nvim-cmp completion sources
  { "hrsh7th/cmp-nvim-lsp", dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-path", dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-buffer", dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-omni", dependencies = "nvim-cmp" },
  { "quangnguyen30192/cmp-nvim-ultisnips", dependencies ={ "nvim-cmp", "ultisnips" } },
  {
    "hrsh7th/cmp-emoji",
    enabled = vim.g.is_mac,
    dependencies = "nvim-cmp",
  },

  -- ============================================
  -- LSP
  -- ============================================
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    config = function() require("config.mason") end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = "cmp-nvim-lsp",
    config = function() require("config.lsp") end,
  },

  -- ============================================
  -- Treesitter
  -- ============================================
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    build = ":TSUpdate",
    config = function() require("config.treesitter") end,
  },

  -- ============================================
  -- Language specific
  -- ============================================
  { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
  { "jeetsukumaran/vim-pythonsense", ft = { "python" } },
  { "machakann/vim-swap", event = "VimEnter" },

  {
    "vlime/vlime",
    enabled = function() return utils.executable("sbcl") end,
    ft = { "lisp" },
  },

  -- ============================================
  -- Navigation
  -- ============================================
  {
    "folke/flash.nvim",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("config.flash")
      end, 2000)
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
    config = function() require("config.hlslens") end,
  },

  -- ============================================
  -- Fuzzy search
  -- ============================================
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "ibhagwan/fzf-lua",
  },

  -- ============================================
  -- Colorschemes (lazy loaded)
  -- ============================================
  { "navarasu/onedark.nvim", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "olimorris/onedarkpro.nvim", lazy = true },
  { "tanvirtin/monokai.nvim", lazy = true },
  { "marko-cerovac/material.nvim", lazy = true },

  -- ============================================
  -- UI
  -- ============================================
  { "nvim-tree/nvim-web-devicons", event = "VimEnter" },

  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    cond = firenvim_not_active,
    config = function() require("config.statusline") end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VimEnter",
    cond = firenvim_not_active,
    config = function() require("config.bufferline") end,
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    cond = firenvim_not_active,
    config = function() require("config.dashboard-nvim") end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    config = function() require("config.indent-blankline") end,
  },

  { "itchyny/vim-highlighturl", event = "VimEnter" },

  {
    "rcarriga/nvim-notify",
    event = "BufEnter",
    config = function()
      vim.defer_fn(function()
        require("config.nvim-notify")
      end, 2000)
    end,
  },

  -- Visual scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufEnter",
    config = function() require("scrollbar").setup() end,
  },

  -- Diagnostics panel
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- ============================================
  -- Utilities
  -- ============================================
  {
    "tyru/open-browser.vim",
    enabled = vim.g.is_win or vim.g.is_mac,
    event = "VimEnter",
  },

  {
    "liuchengxu/vista.vim",
    enabled = function() return utils.executable("ctags") end,
    cmd = "Vista",
  },

  { "preservim/tagbar", cmd = { "TagbarToggle" } },

  -- Snippet engine and snippet template
  { "SirVer/ultisnips", event = "InsertEnter" },
  { "honza/vim-snippets", dependencies = "ultisnips" },

  -- Automatic insertion and deletion of a pair of characters
  { "Raimondi/delimitMate", event = "InsertEnter" },

  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    event = "VimEnter",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Autosave files on certain events
  { "907th/vim-auto-save", event = "InsertEnter" },

  -- Show undo history visually
  { "mbbill/undotree", cmd = { "UndotreeToggle", "UndotreeShow" } },

  -- better UI for some nvim actions
  { "stevearc/dressing.nvim" },

  -- Manage your yank history
  {
    "gbprod/yanky.nvim",
    config = function() require("config.yanky") end,
  },

  -- Handy unix command inside Vim (Rename, Move etc.)
  { "tpope/vim-eunuch", cmd = { "Rename", "Delete" } },

  -- Safe buffer closing (delete buffer without closing window)
  { "famiu/bufdelete.nvim", event = "VimEnter" },

  -- Repeat vim motions
  { "tpope/vim-repeat", event = "VimEnter" },

  { "nvim-zh/better-escape.vim", event = "InsertEnter" },

  -- Platform-specific input method
  {
    "lyokha/vim-xkbswitch",
    enabled = vim.g.is_mac,
    event = "InsertEnter",
  },
  {
    "Neur1n/neuims",
    enabled = vim.g.is_win,
    event = "InsertEnter",
  },

  -- ============================================
  -- Formatting
  -- ============================================
  { "sbdchd/neoformat", cmd = { "Neoformat" } },

  -- ============================================
  -- Git
  -- ============================================
  {
    "tpope/vim-fugitive",
    event = "User InGitRepo",
    config = function() require("config.fugitive") end,
  },

  {
    "rbong/vim-flog",
    dependencies = "tpope/vim-fugitive",
    cmd = { "Flog" },
  },

  {
    "christoomey/vim-conflicted",
    dependencies = "tpope/vim-fugitive",
    cmd = { "Conflicted" },
  },

  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "User InGitRepo",
    config = function() require("config.git-linker") end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User InGitRepo",
    config = function() require("config.gitsigns") end,
  },

  { "rhysd/committia.vim", lazy = true },

  { "kevinhwang91/nvim-bqf", ft = "qf", config = function() require("config.bqf") end },

  -- Improved diff view
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Terminal git UI (requires lazygit to be installed)
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- ============================================
  -- Markdown
  -- ============================================
  { "preservim/vim-markdown", ft = { "markdown" } },
  { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } },
  { "godlygeek/tabular", cmd = { "Tabularize" } },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && git checkout -- .",
    ft = { "markdown" },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function() require("config.zen-mode") end,
  },

  {
    "rhysd/vim-grammarous",
    enabled = vim.g.is_mac,
    ft = { "markdown" },
  },

  -- ============================================
  -- Text objects and editing
  -- ============================================
  { "chrisbra/unicode.vim", event = "VimEnter" },

  -- Additional powerful text object for vim
  { "wellle/targets.vim", event = "VimEnter" },

  -- Plugin to manipulate character pairs quickly
  {
    "kylechui/nvim-surround",
  version = "*",
    event = "VimEnter",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Add indent object for vim (useful for languages like Python)
  { "michaeljsmith/vim-indent-object", event = "VimEnter" },

  -- Project-wide search and replace
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Interactive search and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
  },

  -- ============================================
  -- LaTeX
  -- ============================================
  {
    "lervag/vimtex",
    enabled = function() return utils.executable("latex") end,
    ft = { "tex" },
  },

  -- ============================================
  -- Tmux
  -- ============================================
  {
    "tmux-plugins/vim-tmux",
    enabled = function() return utils.executable("tmux") end,
    ft = { "tmux" },
  },

  -- ============================================
  -- Matchup
  -- ============================================
  {
    "andymass/vim-matchup",
    event = "VimEnter",
    init = function()
      -- Disable treesitter backend to avoid compatibility issues
      vim.g.matchup_matchparen_nomode = 0
      vim.g.matchup_matchparen_offscreen = {}
      vim.g.matchup_transmute_enabled = 0
      vim.g.matchup_treesitter_config = { disable = true }
    end,
    config = function()
      -- Force disable treesitter engine after load
      vim.cmd([[let g:matchup_treesitter_config = {'disable': 1}]])
    end,
  },

  -- ============================================
  -- Misc
  -- ============================================
  { "tpope/vim-scriptease", cmd = { "Scriptnames", "Message", "Verbose" } },

  -- Asynchronous command execution
  { "skywind3000/asyncrun.vim", cmd = { "AsyncRun" } },

  { "cespare/vim-toml", branch = "main", ft = { "toml" } },

  -- Edit text area in browser using nvim
  {
    "glacambre/firenvim",
    enabled = vim.g.is_win or vim.g.is_mac,
    lazy = true,
    build = function() vim.fn["firenvim#install"](0) end,
  },

  -- Debugger plugin
  {
    "sakhnik/nvim-gdb",
    enabled = vim.g.is_win or vim.g.is_linux,
    lazy = true,
    build = "bash install.sh",
  },

  -- Automatic session management
  {
    "rmagatti/auto-session",
    config = function() require("config.auto-session") end,
  },

  {
    "ojroques/vim-oscyank",
    enabled = vim.g.is_linux,
    cmd = { "OSCYank", "OSCYankReg" },
  },

  -- The missing auto-completion for cmdline!
  { "gelguy/wilder.nvim", lazy = false },

  -- showing keybindings
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("config.which-key")
      end, 2000)
    end,
  },

  -- show and trim trailing whitespaces
  { "jdhao/whitespace.nvim", event = "VimEnter" },

  -- file explorer
  { "preservim/nerdtree", event = "VimEnter" },

  { "ii14/emmylua-nvim", ft = "lua" },

  {
    "j-hui/fidget.nvim",
    dependencies = "nvim-lspconfig",
    tag = "legacy",
    config = function() require("config.fidget-nvim") end,
  },

}, {
  -- lazy.nvim global options
  checker = {
    enabled = false,
  },
})
