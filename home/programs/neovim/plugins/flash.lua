require("flash").setup({
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
        multi_window = true,
        forward = true,
        wrap = true,
        mode = "exact",
    },
    jump = {
        jumplist = true,
        pos = "start",
        history = false,
        register = false,
        nohlsearch = true,
        autojump = false,
    },
    modes = {
        char = {
            enabled = true,
            jump_labels = true,
            keys = { "f", "F", "t", "T", ";", "," },
        },
        search = {
            enabled = true,
        },
        treesitter = {
            labels = "abcdefghijklmnopqrstuvwxyz",
            jump = { pos = "range" },
            highlight = {
                backdrop = false,
                matches = false,
            },
        },
    },
})

local map = vim.keymap.set
map({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end, { desc = "Flash jump" })
map({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, { desc = "Flash treesitter" })
map("o", "r", function()
    require("flash").remote()
end, { desc = "Flash remote" })
map({ "x", "o" }, "R", function()
    require("flash").treesitter_search()
end, { desc = "Flash treesitter search" })
map("c", "<C-s>", function()
    require("flash").toggle()
end, { desc = "Toggle flash search" })
