local wk = require("which-key")

wk.setup({
    preset = "modern",
    delay = 300,
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
    win = {
        border = "rounded",
        padding = { 1, 2 },
    },
    layout = {
        width = { min = 20 },
        spacing = 3,
    },
})

-- Group labels
wk.add({
    { "<leader>a", group = "ai" },
    { "<leader>b", group = "buffer" },
    { "<leader>c", group = "code" },
    { "<leader>d", group = "debug" },
    { "<leader>f", group = "find/files" },
    { "<leader>g", group = "git" },
    { "<leader>gf", group = "file history" },
    { "<leader>gh", group = "hunks" },
    { "<leader>h", group = "harpoon" },
    { "<leader>l", group = "lsp" },
    { "<leader>n", group = "noice" },
    { "<leader>s", group = "search" },
    { "<leader>u", group = "ui" },
    { "<leader>x", group = "diagnostics/quickfix" },
})
