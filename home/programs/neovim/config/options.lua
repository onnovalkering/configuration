local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.colorcolumn = "100"

-- Behavior
opt.hidden = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Command line
opt.cmdheight = 1

-- Characters
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Diff
opt.diffopt:append("vertical")
