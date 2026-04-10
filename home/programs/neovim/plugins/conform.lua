require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
        nix = { "nixfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        gleam = { "gleam" },
        bash = { "shfmt" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        rescript = { "rescript" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
    formatters = {
        rescript = {
            command = "rescript",
            args = { "format", "-stdin", ".res" },
            stdin = true,
        },
        sql_formatter = {
            command = "sql-formatter",
            args = { "--language", "postgresql" },
            stdin = true,
        },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
