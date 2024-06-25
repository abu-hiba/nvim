-- requires typescript-language-server to be installed:
-- npm i -g typescript-language-server

local function start_tsserver()
				local root_files = {'package.json', 'tsconfig.json', 'jsconfig.json'}
				local paths = vim.fs.find(root_files, {stop = vim.env.HOME})
				local root_dir = vim.fs.dirname(paths[1])
				
				if root_dir == nil then
								error("Could not find root_dir")
				end

				vim.lsp.start({
								name = 'tsserver',
								cmd = { 'typescript-language-server', '--stdio' },
								root_dir = root_dir,
								init_options = {hostInfo = 'neovim'},
				})
end

vim.api.nvim_create_autocmd('FileType', {
				pattern = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
				desc = 'Start JavaScript/TypeScript LSP',
				callback = start_tsserver,
})
