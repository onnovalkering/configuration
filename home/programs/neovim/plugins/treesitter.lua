-- nvim-treesitter `main` moved highlight + indent to Neovim core;
-- enable them per-buffer via FileType instead of a global setup() call.
local group = vim.api.nvim_create_augroup("treesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
        local buf = args.buf

        -- old highlight.disable guard: skip very large files
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return
        end

        -- highlight = { enable = true }
        if not pcall(vim.treesitter.start, buf) then
            return -- no parser for this filetype
        end

        -- indent = { enable = true }
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
    desc = "Enable treesitter highlight + indent",
})

-- textobjects: options stay in setup(); keymaps move to vim.keymap.set.
-- af/if/ac/ic (function/class) are provided by mini.ai; only parameter here.
require("nvim-treesitter-textobjects").setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

vim.keymap.set({ "x", "o" }, "aa", function()
    select.select_textobject("@parameter.outer")
end, { desc = "around parameter" })
vim.keymap.set({ "x", "o" }, "ia", function()
    select.select_textobject("@parameter.inner")
end, { desc = "inside parameter" })

local function mv(fn, q)
    return function()
        move[fn](q)
    end
end
vim.keymap.set({ "n", "x", "o" }, "]f", mv("goto_next_start", "@function.outer"), { desc = "next function start" })
vim.keymap.set({ "n", "x", "o" }, "]c", mv("goto_next_start", "@class.outer"), { desc = "next class start" })
vim.keymap.set({ "n", "x", "o" }, "]F", mv("goto_next_end", "@function.outer"), { desc = "next function end" })
vim.keymap.set({ "n", "x", "o" }, "]C", mv("goto_next_end", "@class.outer"), { desc = "next class end" })
vim.keymap.set({ "n", "x", "o" }, "[f", mv("goto_previous_start", "@function.outer"), { desc = "prev function start" })
vim.keymap.set({ "n", "x", "o" }, "[c", mv("goto_previous_start", "@class.outer"), { desc = "prev class start" })
vim.keymap.set({ "n", "x", "o" }, "[F", mv("goto_previous_end", "@function.outer"), { desc = "prev function end" })
vim.keymap.set({ "n", "x", "o" }, "[C", mv("goto_previous_end", "@class.outer"), { desc = "prev class end" })
