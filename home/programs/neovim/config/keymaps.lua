local map = vim.keymap.set

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Keep cursor centered when searching
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Better paste (don't overwrite register)
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Delete without yanking (uses X to avoid blocking <leader>d* debug keymaps)
map({ "n", "v" }, "<leader>x", [["_d]], { desc = "Delete without yanking" })

-- Quick save / quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all files" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force quit all" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- Split windows
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>wd", "<cmd>close<cr>", { desc = "Close window" })

-- Better command line navigation
map("c", "<C-a>", "<Home>", { desc = "Start of line" })
map("c", "<C-e>", "<End>", { desc = "End of line" })

-- Terminal: escape back to normal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: go left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: go down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: go up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: go right" })

-- Quickfix navigation
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
map("n", "]Q", "<cmd>clast<cr>", { desc = "Last quickfix" })
map("n", "[Q", "<cmd>cfirst<cr>", { desc = "First quickfix" })

-- Location list navigation
map("n", "]l", "<cmd>lnext<cr>", { desc = "Next loc list" })
map("n", "[l", "<cmd>lprev<cr>", { desc = "Prev loc list" })

-- Better join (keep cursor in place)
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- Select all (uses <leader>sa to preserve <C-a> increment)
map("n", "<leader>sa", "gg<S-v>G", { desc = "Select all" })

-- UI toggles
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
map("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle spell" })
map("n", "<leader>un", "<cmd>set number!<cr>", { desc = "Toggle line numbers" })
map("n", "<leader>ur", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative numbers" })
