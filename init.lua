-- Basic Editor Settings
vim.g.mapleader = " "
vim.o.completeopt = "menu,menuone,noselect" -- Better completion experience
vim.o.updatetime = 300                      -- Faster diagnostics
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.cmd "colorscheme retrobox"

-- Bootstrap lazy.nvim (Plugin Manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up Plugins
require("lazy").setup({
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",                -- Autocompletion engine
  "hrsh7th/cmp-nvim-lsp",            -- LSP source for nvim-cmp
  "L3MON4D3/LuaSnip",                -- Snippets engine (required for cmp)
  "saadparwaiz1/cmp_luasnip",        -- Snippets source for nvim-cmp
  "williamboman/mason.nvim",         -- Optional: Installer for LSPs
  "williamboman/mason-lspconfig.nvim",
  "lewis6991/gitsigns.nvim",
  {
      'nvim-telescope/telescope.nvim', version = '*',
      dependencies = {
          'nvim-lua/plenary.nvim',
          { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      }
  }
})

-- Telescope Setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Mason Setup
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "clangd" } })

-- Autocompletion Setup
local cmp = require("cmp")
cmp.setup({
  snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(), -- Trigger suggestions manually
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter to select
    ['<Tab>'] = cmp.mapping.select_next_item(), -- Tab to navigate
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Suggestions from code completion
    { name = 'luasnip' },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable("clang")
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",        -- Index project in background
    "--clang-tidy",              -- Enable linter diagnostics
    "--header-insertion=iwyu",   -- "Include What You Use" (auto-imports)
    "--completion-style=detailed", -- detailed completion info
    "--function-arg-placeholders=1", -- Fill function args with placeholders
    "--fallback-style=llvm",     -- Format style if .clang-format is missing
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

-- Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})    -- Go to Definition
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})          -- Hover documentation
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {}) -- Rename symbol
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {}) -- Code Actions (fixes)

-- Show diagnostics in floating window on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
