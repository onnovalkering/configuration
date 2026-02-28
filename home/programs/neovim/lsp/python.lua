local M = {}

function M.setup(lsp)
    -- basedpyright: type checking, completions
    vim.lsp.config("basedpyright", {
        cmd = { "basedpyright-langserver", "--stdio" },
        root_markers = { "pyproject.toml", ".git" },
        filetypes = { "python" },
        capabilities = lsp.capabilities,
        on_attach = function(client, bufnr)
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.documentFormattingProvider = false
            lsp.on_attach(client, bufnr)
        end,
        settings = {
            basedpyright = {
                analysis = {
                    diagnosticsSeverityOverrides = {
                        reportUnusedCallResult = "none", -- Don't require _ for unused returns
                    },
                },
            },
        },
    })
    vim.lsp.enable("basedpyright")

    -- ruff: linting, formatting
    vim.lsp.config("ruff", {
        cmd = { "ruff", "server" },
        root_markers = { "pyproject.toml", "ruff.toml", ".git" },
        filetypes = { "python" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
    })
    vim.lsp.enable("ruff")
end

return M
