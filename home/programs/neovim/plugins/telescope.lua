local telescope = require("telescope")
local builtin = require("telescope.builtin")
local map = vim.keymap.set

telescope.setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
        },
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<esc>"] = "close",
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

telescope.load_extension("fzf")

-- Files
map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })

-- Git
map("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
map("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })

-- LSP
map("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>lS", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })

-- Misc
map("n", "<leader>fc", builtin.colorscheme, { desc = "Colorschemes" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy search buffer" })
