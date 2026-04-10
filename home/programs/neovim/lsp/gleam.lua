local M = {}

function M.setup(lsp)
    vim.lsp.config("gleam", {
        cmd = { "gleam", "lsp" },
        root_markers = { "gleam.toml", ".git" },
        filetypes = { "gleam" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
    })
    vim.lsp.enable("gleam")
end

return M
