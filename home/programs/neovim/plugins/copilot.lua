require("copilot").setup({
    panel = { enabled = false }, -- use blink-cmp instead
    suggestion = { enabled = false }, -- use blink-cmp instead
    filetypes = {
        yaml = false,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = "node",
})
