vim.g.mapleader = " "

-- Netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>t", vim.cmd.Tex)
vim.keymap.set("n", "<leader>v", vim.cmd.Vex)

-- List and select from buffers
vim.keymap.set("n", "<leader>b", ":ls<CR>:b<Space>")

-- Terminal
vim.keymap.set("n", "<leader>z", ":belowright split | resize 20 | term <CR> :startinsert <CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-v><Esc>", "<Esc>")

-- Moving highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep search terms in center of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keeps yanked text when pasting over another word
vim.keymap.set("x", "<leader>p", "\"_dp")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
