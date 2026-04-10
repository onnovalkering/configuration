local M = {}

function M.setup(lsp)
    vim.lsp.config("bashls", {
        cmd = { "bash-language-server", "start" },
        root_markers = { ".git" },
        filetypes = { "sh", "bash" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        settings = {
            bashIde = {
                globPattern = "*@(.sh|.inc|.bash|.command)",
            },
        },
    })
    vim.lsp.enable("bashls")
end

return M
