local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight text on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
    desc = "Highlight text on yank",
})

-- Restore cursor position on file open
autocmd("BufReadPost", {
    group = augroup("restore_cursor", { clear = true }),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = "Restore last cursor position",
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    group = augroup("trim_whitespace", { clear = true }),
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype
        -- Skip filetypes where trailing whitespace is meaningful
        local skip = { "markdown", "diff" }
        if not vim.tbl_contains(skip, ft) then
            local pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("silent! undojoin")
            vim.cmd([[%s/\s\+$//e]])
            vim.api.nvim_win_set_cursor(0, pos)
        end
    end,
    desc = "Remove trailing whitespace on save",
})

-- Close certain windows with just 'q'
autocmd("FileType", {
    group = augroup("close_with_q", { clear = true }),
    pattern = {
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "startuptime",
        "tsplayground",
        "checkhealth",
        "aerial",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close window" })
    end,
    desc = "Close float/utility windows with q",
})

-- Resize splits when terminal window is resized
autocmd("VimResized", {
    group = augroup("resize_splits", { clear = true }),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
    desc = "Resize splits on terminal resize",
})

-- Set wrap and spell in text files
autocmd("FileType", {
    group = augroup("wrap_spell", { clear = true }),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
    desc = "Enable wrap and spell in text files",
})

-- Auto-create parent directories on save
autocmd("BufWritePre", {
    group = augroup("auto_create_dir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
    desc = "Create parent dirs on save",
})
