vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<Esc>")

-- Netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>t", vim.cmd.Tex)
vim.keymap.set("n", "<leader>v", vim.cmd.Vex)

-- List and select from buffers
vim.keymap.set("n", "<leader>b", ":ls<CR>:b<Space>")

-- Terminal
vim.keymap.set("n", "<leader>z", ":belowright split | resize 20 | term <CR> :startinsert <CR>")
vim.keymap.set("t", "jj", "<C-\\><C-n>")
vim.keymap.set("t", "<C-v><Esc>", "<Esc>")

-- Moving highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep search terms in center of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keeps yanked text when pasting over another word
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Resize windows
vim.keymap.set("n", "<C-k>", ":resize +5<CR>")
vim.keymap.set("n", "<C-j>", ":resize -5<CR>")
vim.keymap.set("n", "<C-l>", ":vertical resize +5<CR>")
vim.keymap.set("n", "<C-h>", ":vertical resize -5<CR>")

-- Convenience
vim.keymap.set("n", "<leader>;", "A;<Esc>") -- Add semicolon at end of line
