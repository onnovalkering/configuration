local M = {}

function M.setup(lsp)
    vim.g.rustaceanvim = {
        server = {
            capabilities = lsp.capabilities,
            on_attach = lsp.on_attach,
        },
    }
end

return M
