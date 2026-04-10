local M = {}

function M.setup(lsp)
    -- JSON
    vim.lsp.config("jsonls", {
        cmd = { "vscode-json-language-server", "--stdio" },
        root_markers = { ".git" },
        filetypes = { "json", "jsonc" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        settings = {
            json = {
                validate = { enable = true },
                schemas = {
                    { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
                    { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
                    {
                        fileMatch = { ".eslintrc", ".eslintrc.json" },
                        url = "https://json.schemastore.org/eslintrc.json",
                    },
                    {
                        fileMatch = { ".prettierrc", ".prettierrc.json" },
                        url = "https://json.schemastore.org/prettierrc.json",
                    },
                },
            },
        },
        init_options = {
            provideFormatter = true,
        },
    })
    vim.lsp.enable("jsonls")

    -- HTML
    vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        root_markers = { ".git" },
        filetypes = { "html", "htmldjango" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        init_options = {
            provideFormatter = true,
            embeddedLanguages = { css = true, javascript = true },
        },
    })
    vim.lsp.enable("html")

    -- CSS
    vim.lsp.config("cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        root_markers = { ".git" },
        filetypes = { "css", "scss", "less" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
        },
    })
    vim.lsp.enable("cssls")
end

return M
