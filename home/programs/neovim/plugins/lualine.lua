require("lualine").setup({
    options = {
        -- catppuccin/nvim renamed the bundled theme: the old "catppuccin"
        -- file is gone, replaced by per-flavor files. Pinned to mocha to
        -- match catppuccin.nvim.flavor and avoid load-order dependence.
        theme = "catppuccin-mocha",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            { "branch", icon = "" },
            {
                "diff",
                symbols = { added = " ", modified = " ", removed = " " },
            },
        },
        lualine_c = {
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
            {
                "diagnostics",
                symbols = { error = " ", warn = " ", info = " ", hint = "󰝶 " },
            },
            { "filetype", icon_only = false },
            { "encoding" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    extensions = { "trouble", "oil", "aerial" },
})
