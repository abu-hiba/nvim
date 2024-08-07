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

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            -- LSP support
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            -- Autocompletion
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            -- Snippets
            "L3MON4D3/LuaSnip",
        },
    },
    {
        "prichrd/netrw.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    "windwp/nvim-ts-autotag",
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    -- Colorschemes
    {"catppuccin/nvim"},
    {"folke/tokyonight.nvim"},
    {"rebelot/kanagawa.nvim"},
    {"EdenEast/nightfox.nvim"},
    --
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",
    "karb94/neoscroll.nvim",
    "github/copilot.vim",
    "tpope/vim-surround",
    "vim-test/vim-test",
})
