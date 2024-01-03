require("gitsigns").setup {
    numhl = true,
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 200,
    },
    current_line_blame_formatter = "<author>, <author_time:%d-%m-%Y> - <summary>",
}
