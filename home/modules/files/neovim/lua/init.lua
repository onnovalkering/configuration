local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

require('packer').startup(function()
    use 'projekt0n/github-nvim-theme'

    -- LSP configuration & plugins
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Status updates for LSP
            'j-hui/fidget.nvim',
        },
    }

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = { 
            -- Use LSP for completion
            'hrsh7th/cmp-nvim-lsp', 
        },
    }

    -- Syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- Fuzzy Finder (files, lsp, etc)
    use { 
        'nvim-telescope/telescope.nvim', 
        branch = '0.1.x', 
        requires = { 
            'nvim-lua/plenary.nvim' 
        } 
    }  

    -- Statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 
            'kyazdani42/nvim-web-devicons'
        }
    }    
end)

-- Customization
require('config.lsp')
require('config.statusline')
require('config.telescope')
require('config.theme')
require('config.treesitter')

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
