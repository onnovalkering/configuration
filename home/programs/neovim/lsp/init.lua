local M = {}

M.capabilities = require("blink.cmp").get_lsp_capabilities()

---@diagnostic disable-next-line: unused-local
M.on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    -- Navigation
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gr", vim.lsp.buf.references, "Go to references")
    map("gI", vim.lsp.buf.implementation, "Go to implementation")
    map("gy", vim.lsp.buf.type_definition, "Go to type definition")

    -- Information
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Actions
    map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>la", vim.lsp.buf.code_action, "Code action")
    map("<leader>lf", vim.lsp.buf.format, "Format buffer")

    -- Diagnostics
    map("[d", vim.diagnostic.jump({ count = -1 }), "Previous diagnostics")
    map("]d", vim.diagnostic.jump({ count = 1 }), "Next diagnostics")
    map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
end

-- Diagnostics
vim.diagnostic.config({
    virtual_text = { spacing = 4, prefix = "●" },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = true },
})

-- Languages
require("lsp.lua").setup(M)
require("lsp.nix").setup(M)
require("lsp.python").setup(M)
require("lsp.rust").setup(M)
