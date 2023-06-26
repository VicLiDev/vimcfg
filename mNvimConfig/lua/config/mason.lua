-- require("mason").setup()
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
-- require("mason-lspconfig").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        -- "vim-language-server",
        "clangd",
        "lua_ls",
        "pyright",
        "rust_analyzer" },
}
