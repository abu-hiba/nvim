local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return branch
    else
        return ""
    end
end

local function git_push_set_upstream()
    local branch = branch_name()
    return vim.cmd("Git push -u origin " .. branch)
end

local function git_switch(args)
    return vim.cmd("Git switch " .. args[1])
end

local function git_switch_create(args)
    return vim.cmd("Git switch -c " .. args[1])
end

local function git_switch_main()
    return vim.cmd("Git switch main")
end

vim.keymap.set("n", "<leader>gs", ":Git<CR><C-w>T")
vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
vim.keymap.set("n", "<leader>gl", ":Git pull<CR>")
vim.keymap.set("n", "<leader>gb", ":Git branch<CR>")
vim.api.nvim_create_user_command('Gpsup', git_push_set_upstream, {})
vim.api.nvim_create_user_command('Gsw', git_switch, {})
vim.api.nvim_create_user_command('Gswc', git_switch_create, {})
vim.api.nvim_create_user_command('Gswm', git_switch_main, {})
