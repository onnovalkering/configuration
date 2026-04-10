require("todo-comments").setup({
    signs = true,
    sign_priority = 8,
    keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
    },
    colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF006E" },
    },
})

local map = vim.keymap.set
map("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next TODO comment" })
map("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Prev TODO comment" })
map("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs (telescope)" })
map("n", "<leader>sT", "<cmd>Trouble todo toggle<cr>", { desc = "TODOs (trouble)" })
