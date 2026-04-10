require("render-markdown").setup({
    enabled = true,
    render_modes = { "n", "c" }, -- render in normal and command mode, raw in insert
    heading = {
        enabled = true,
        sign = false,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    code = {
        enabled = true,
        sign = false,
        style = "full",
        border = "thin",
        above = " ",
        below = " ",
    },
    bullet = {
        enabled = true,
        icons = { "", "", "", "" },
    },
    checkbox = {
        enabled = true,
        unchecked = { icon = " " },
        checked = { icon = " " },
    },
    pipe_table = {
        enabled = true,
        style = "full",
        cell = "padded",
    },
    link = {
        enabled = true,
        hyperlink = " ",
        custom = {
            web = { pattern = "^http", icon = " " },
        },
    },
})
