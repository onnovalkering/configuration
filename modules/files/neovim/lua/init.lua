local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

require('packer').startup(function()
    use 'neovim/nvim-lspconfig'
    use 'projekt0n/github-nvim-theme'
    use 'williamboman/nvim-lsp-installer'
end)

-- Customization
require('config.lsp')
require('config.statusline')
require('config.telescope')
require('config.treesitter')

-- Theme
require('github-theme').setup {
  theme_style = 'dimmed'
}

-- Settings
local function setl(opt, value)
  vim.cmd(":set "..opt..(value and "="..value or ""))
end

setl('expandtab')
setl('formatoptions', 'tqj')
setl('shiftwidth', 4)
setl('smartindent')
setl('tabstop', 4)
setl('termguicolors')

-- Numbers

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

setl('cursorline')
setl('foldexpr', 'nvim_treesitter#foldexpr()')
setl('foldmethod', 'expr')
setl('linebreak')
setl('signcolumn', 'yes')

-- Mappings
g.mapleader = ";"

local function map(mode, lhs, rhs, opts)
    local options = {
        noremap = true,
        silent = true
    }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<Leader>cf", ":Lspsaga lsp_finder<CR>")
map("n", "<leader>ca", ":Lspsaga code_action<CR>")
map("n", "<leader>ch", ":Lspsaga hover_doc<CR>")
map("n", "<leader>cs", ":Lspsaga signature_help<CR>")
map("n", "<leader>cr", ":Lspsaga rename<CR>")
map("n", "<leader>cd", ":Lspsaga preview_definition<CR>")

map("n", "<Leader>B", ":Telescope file_browser<CR>")
map("n", "<Leader>f", ":Telescope find_files<CR>")

map("n", "<Leader>t", ":NvimTreeToggle<CR>")
map("n", "<Leader>br", ":NvimTreeRefresh<CR>")
map("n", "<Leader>bf", ":NvimTreeFindFile<CR>")
