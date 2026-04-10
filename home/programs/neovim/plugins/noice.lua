require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        },
        hover = { enabled = true },
        signature = { enabled = false }, -- handled by blink.cmp
        progress = {
            enabled = true,
            throttle = 1000 / 30,
            view = "mini",
        },
    },
    routes = {
        -- Route long messages to split
        { filter = { event = "msg_show", min_height = 10 }, view = "split" },
        -- Skip "written" messages
        { filter = { event = "msg_show", find = "%d+L, %d+B" }, view = "mini" },
        { filter = { event = "msg_show", find = "; after #%d+" }, skip = true },
        { filter = { event = "msg_show", find = "; before #%d+" }, skip = true },
        { filter = { event = "msg_show", find = "lines" }, view = "mini" },
    },
    presets = {
        bottom_search = true, -- cmdline at bottom for search
        command_palette = true, -- cmdline + popupmenu together
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true, -- borders on hover/signature
    },
    views = {
        cmdline_popup = {
            position = { row = "40%", col = "50%" },
            size = { width = 60, height = "auto" },
            border = { style = "rounded" },
        },
        popupmenu = {
            relative = "editor",
            position = { row = "45%", col = "50%" },
            size = { width = 60, height = 10 },
            border = { style = "rounded", padding = { 0, 1 } },
            win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
        },
        mini = {
            timeout = 3000,
            zindex = 60,
            position = { row = -2, col = "100%" },
            size = { width = "auto", height = "auto" },
            border = { style = "none" },
            win_options = { winblend = 0 },
        },
    },
})

-- Telescope integration for noice history
vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<cr>", { desc = "Noice last message" })
vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<cr>", { desc = "Noice history" })
vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<cr>", { desc = "Dismiss all notifications" })
vim.keymap.set("n", "<leader>nt", "<cmd>Noice telescope<cr>", { desc = "Noice telescope" })
