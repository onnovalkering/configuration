local nvim_lsp = require('lspconfig')
local saga = require 'lspsaga'
local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

local on_attach = function(client, bufnr)
    require'completion'.on_attach(client, bufnr)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = {
        noremap = true,
        silent = true
    }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

    -- Custom completion icons
    protocol.CompletionItemKind = {'', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '' -- TypeParameter
    }
end

saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = "round"
}

-- Automatically install servers
local servers = {
    "bashls",
    "clangd",
    "cssls",
    "htmlls",
    "jsonls",
    "pyright",
    "yamlls",
}

for i, name in ipairs(servers) do
    local ok, server = lsp_installer_servers.get_server(name)
    if ok then
        if not server:is_installed() then
            server:install()
        end
    end
end

-- Setup
require('rust-tools').setup({})

lsp_installer.on_server_ready(function(server)
    local opts = {}

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)



