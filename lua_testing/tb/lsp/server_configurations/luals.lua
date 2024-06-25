-- requires lua-language-server to be installed:
-- brew install lua-language-server

local function start_luals()
    local root_files = {'.luarc.json', '.git'}
    local paths = vim.fs.find(root_files, {stop = vim.env.HOME})
    local root_dir = vim.fs.dirname(paths[1])

    if root_dir == nil then
        error("Could not find root_dir")
    end

    vim.lsp.start({
        cmd = { 'lua-language-server' },
        root_dir = root_dir,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = {'vim'},
                },
            }
        }
    })
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'lua'},
    desc = 'Start Lua LSP',
    callback = start_luals,
})
