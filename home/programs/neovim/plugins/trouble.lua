require("trouble").setup({
    modes = {
        diagnostics = {
            auto_open = false,
            auto_close = true,
            focus = true,
        },
    },
    icons = {
        indent = {
            middle = " ",
            last = " ",
            top = " ",
            ws = "│  ",
        },
        folder_closed = " ",
        folder_open = " ",
        kinds = {
            Array = " ",
            Boolean = "󰨙 ",
            Class = " ",
            Constant = "󰏿 ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Function = "󰊕 ",
            Interface = " ",
            Key = " ",
            Method = "󰊕 ",
            Module = " ",
            Namespace = "󰦮 ",
            Null = " ",
            Number = "󰎠 ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            String = " ",
            Struct = "󰆼 ",
            TypeParameter = " ",
            Variable = "󰀫 ",
        },
    },
})

local map = vim.keymap.set
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (workspace)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (buffer)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP definitions" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
