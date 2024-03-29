require("lualine").setup {
    options = {
        component_separators = "|",
        -- component_separators = { left = "\\", right = "/" },
        section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
        lualine_c = { "%<%f" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "%<%f" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = { function() return "" end },
        lualine_b = {
            {
                "tabs",
                mode = 1,
                use_mode_colors = true,
            }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
}
