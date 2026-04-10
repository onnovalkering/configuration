require("diffview").setup({
    diff_binaries = false,
    enhanced_diff_hl = true,
    git_cmd = { "git" },
    hg_cmd = { "chg" },
    use_icons = true,
    show_help_hints = true,
    watch_index = true,
    icons = {
        folder_closed = "",
        folder_open = "",
    },
    signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
    },
    view = {
        default = {
            layout = "diff2_horizontal",
            winbar_info = true,
        },
        merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
        },
        file_history = {
            layout = "diff2_horizontal",
            winbar_info = true,
        },
    },
    file_panel = {
        listing_style = "tree",
        tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
        },
        win_config = {
            position = "left",
            width = 35,
            win_opts = {},
        },
    },
    keymaps = {
        view = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_panel = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_history_panel = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
    },
})

local map = vim.keymap.set
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })
map("n", "<leader>gfh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
map("n", "<leader>gfH", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo history" })
map("v", "<leader>gfh", "<cmd>'<,'>DiffviewFileHistory<cr>", { desc = "Range history" })
