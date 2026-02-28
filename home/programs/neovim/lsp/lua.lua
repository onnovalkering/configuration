local M = {}

function M.setup(lsp)
    require("lazydev").setup({
        library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
    })

    vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        root_markers = { ".luarc.json", ".git" },
        filetypes = { "lua" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    disable = { "missing-fields" },
                },
            },
        },
    })
    vim.lsp.enable("lua_ls")
end

return M
