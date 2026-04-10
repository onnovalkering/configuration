require("hardtime").setup({
    enabled = true,
    max_count = 5,
    disable_mouse = true,
    disabled_keys = {
        ["<Up>"] = { "n", "x" },
        ["<Down>"] = { "n", "x" },
        ["<Left>"] = { "n", "x" },
        ["<Right>"] = { "n", "x" },
    },
    hint = true,
    notification = true,
})
