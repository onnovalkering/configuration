local M = {}

function M.setup(lsp)
    local capabilities = vim.tbl_deep_extend("force", lsp.capabilities, {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    })

    vim.lsp.config("rescriptls", {
        cmd = { "bunx", "@rescript/language-server", "--stdio" },
        root_markers = { "rescript.json", "bsconfig.json", ".git" },
        filetypes = { "rescript" },
        capabilities = capabilities,
        on_attach = lsp.on_attach,
        init_options = {
            extensionConfiguration = {
                allowBuiltInFormatter = true,
                incrementalTypechecking = {
                    enabled = true,
                    acrossFiles = true,
                },
                cache = { projectConfig = { enabled = true } },
                codeLens = true,
                inlayHints = { enable = true },
            },
        },
    })
    vim.lsp.enable("rescriptls")
end

return M
