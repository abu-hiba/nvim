local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "vimdoc", "lua", "javascript", "html", "typescript", "cpp" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    additional_vim_regex_highlighting = false,
})
