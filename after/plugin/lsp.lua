local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>.", function() vim.lsp.buf.code_action() end, opts)

    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

    lsp_zero.set_sign_icons({
      error = "",
      warn = "",
      hint = "",
      info = "",
    })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "lua_ls", "rust_analyzer", "html" },
    handlers = {
        lsp_zero.default_setup,

        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require "lspconfig".lua_ls.setup(lua_opts)
        end,

        clangd = function()
            require "lspconfig".clangd.setup {}
        end,

        html = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            require "lspconfig".html.setup {
                capabilities = capabilities,
            }
        end,
    }
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer",  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
})
