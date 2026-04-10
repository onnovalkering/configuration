require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            buffer = {
                min_keyword_length = 3,
                max_items = 5,
            },
        },
    },

    completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "rounded" },
        },
        ghost_text = { enabled = true },
        menu = {
            border = "rounded",
            draw = {
                treesitter = { "lsp" },
                columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            },
        },
    },

    snippets = { preset = "default" },

    signature = {
        enabled = true,
        window = { border = "rounded" },
    },
})
