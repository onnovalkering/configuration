local configs = require 'nvim-treesitter.configs'
local parsers = require 'nvim-treesitter.parsers'

configs.setup {
    highlight = {
        enable = true,
        disable = {}
    },
    indent = {
        enable = false,
        disable = {}
    },
    ensure_installed = {"tsx", "toml", "json", "yaml", "html", "scss", "rust", "python"}
}