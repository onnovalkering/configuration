require("yanky").setup({
    ring = {
        history_length = 100,
        storage = "shada",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
        update_register_on_cycle = false,
    },
    picker = {
        select = {
            action = nil, -- defaults to put_after
        },
        telescope = {
            use_default_mappings = true,
            mappings = nil,
        },
    },
    system_clipboard = {
        sync_with_ring = true,
    },
    highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
    },
    preserve_cursor_position = {
        enabled = true,
    },
    textobj = {
        enabled = true,
    },
})

local map = vim.keymap.set
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put after" })
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put before" })
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "GPut after" })
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "GPut before" })
map("n", "<C-p>", "<Plug>(YankyPreviousEntry)", { desc = "Yank ring previous" })
map("n", "<C-n>", "<Plug>(YankyNextEntry)", { desc = "Yank ring next" })
map("n", "<leader>sy", "<cmd>YankyRingHistory<cr>", { desc = "Yank history" })
