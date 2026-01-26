local M = {}

function M.setup(lsp)
  vim.lsp.config("nil_ls", {
    cmd = { "nil" },
    root_markers = { "flake.nix", ".git" },
    filetypes = { "nix" },
    capabilities = lsp.capabilities,
    on_attach = lsp.on_attach,
    settings = {
      ["nil"] = {
        formatting = { command = { "nixfmt" } },
      },
    },
  })
  vim.lsp.enable("nil_ls")
end

return M
