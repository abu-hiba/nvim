vim.keymap.set("n", "<leader>gs", ":Git<CR><C-w>T")
vim.keymap.set("n", "<leader>gp", ":Git push<CR><C-w>k")

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

vim.api.nvim_create_user_command('Gpsup', git_push_set_upstream, {})
