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
opt.sidescrolloff = 8
opt.colorcolumn = "100"
opt.showmode = false -- shown by lualine
opt.laststatus = 3 -- global statusline

-- Smooth scrolling (nvim 0.10+)
opt.smoothscroll = true

-- Folding (treesitter-based)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99 -- open all folds by default
opt.foldlevelstart = 99

-- Behavior
opt.updatetime = 250
opt.timeoutlen = 300
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"
opt.pumheight = 10 -- max completion menu height

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

-- Better grep (use ripgrep if available)
if vim.fn.executable("rg") == 1 then
    opt.grepprg = "rg --vimgrep --smart-case"
    opt.grepformat = "%f:%l:%c:%m"
end
