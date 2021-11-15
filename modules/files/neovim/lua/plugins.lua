local fn = vim.fn

require('packer').startup(function()
    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}
    }    

    -- LSP support 
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/completion-nvim'
    use 'glepnir/lspsaga.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'williamboman/nvim-lsp-installer'

    -- Statusline
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', 'arkav/lualine-lsp-progress'}
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'}
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Theme
    use 'projekt0n/github-nvim-theme'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end)


