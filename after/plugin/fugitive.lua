local function branch_name()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return branch
    else
        return ""
    end
end

local function get_branches()
    local output = vim.fn.system("git branch")
    local branches = {}
    for branch in string.gmatch(output, "([^%s]+)") do
        if branch ~= "*" then
            table.insert(branches, branch)
        end
    end
    return branches
end

local function git_push_set_upstream()
    local branch = branch_name()
    return vim.cmd("Git push -u origin " .. branch)
end

local function git_switch(opts)
    local args = opts.fargs
    return vim.cmd("Git switch " .. args[1])
end

local function git_switch_create(opts)
    local args = opts.fargs
    return vim.cmd("Git switch -c " .. args[1])
end

local function git_switch_main()
    return vim.cmd("Git switch main")
end

local function git_branch_delete(opts)
    local args = opts.fargs
    return vim.cmd("Git branch -d " .. args[1])
end

vim.keymap.set("n", "<leader>gs", ":Git<CR><C-w>T")
vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
vim.keymap.set("n", "<leader>gl", ":Git pull<CR>")
vim.keymap.set("n", "<leader>gb", ":Git branch<CR>")
vim.api.nvim_create_user_command('Gpsup', git_push_set_upstream, {})
vim.api.nvim_create_user_command('Gsw', git_switch, { nargs = 1, complete = get_branches })
vim.api.nvim_create_user_command('Gswc', git_switch_create, { nargs = 1 })
vim.api.nvim_create_user_command('Gswm', git_switch_main, {})
vim.api.nvim_create_user_command('Gbd', git_branch_delete, { nargs = 1, complete = get_branches })
