-- mini.ai: extended text objects
require("mini.ai").setup({
    n_lines = 500,
    custom_textobjects = {
        -- Treesitter-based: function, class, block, call, condition
        f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    },
})

-- mini.surround: add/delete/replace surroundings
require("mini.surround").setup({
    mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
    },
})

-- mini.pairs: auto-close brackets/quotes
require("mini.pairs").setup({
    mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
    },
})

-- mini.icons: icon provider (replaces nvim-web-devicons calls)
require("mini.icons").setup()

-- mini.bufremove: smarter buffer deletion
require("mini.bufremove").setup()
vim.keymap.set("n", "<leader>bd", function()
    require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", function()
    require("mini.bufremove").delete(0, true)
end, { desc = "Force delete buffer" })
