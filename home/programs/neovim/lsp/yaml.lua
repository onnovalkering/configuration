local M = {}

function M.setup(lsp)
    vim.lsp.config("yamlls", {
        cmd = { "yaml-language-server", "--stdio" },
        root_markers = { ".git" },
        filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        settings = {
            yaml = {
                keyOrdering = false,
                format = { enable = true },
                validate = true,
                schemaStore = {
                    enable = false,
                    url = "",
                },
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                },
            },
        },
    })
    vim.lsp.enable("yamlls")
end

return M
