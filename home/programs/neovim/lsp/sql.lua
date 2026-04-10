local M = {}

function M.setup(lsp)
    vim.lsp.config("sqls", {
        cmd = { "sqls" },
        root_markers = { ".git", "sqls.yml" },
        filetypes = { "sql", "mysql" },
        capabilities = lsp.capabilities,
        on_attach = function(client, bufnr)
            -- sqls provides code actions for running queries
            lsp.on_attach(client, bufnr)

            vim.keymap.set("n", "<leader>lq", function()
                vim.lsp.buf.code_action()
            end, { buffer = bufnr, desc = "LSP: Run SQL query" })
        end,
        settings = {
            sqls = {
                connections = {
                    -- Add your Postgres connection here, e.g.:
                    -- {
                    --   driver = "postgresql",
                    --   dataSourceName = "host=localhost port=5432 user=postgres dbname=mydb sslmode=disable",
                    -- },
                },
            },
        },
    })
    vim.lsp.enable("sqls")
end

return M
