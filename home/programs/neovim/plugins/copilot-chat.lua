local chat = require("CopilotChat")

chat.setup({
    model = "claude-sonnet-4-5",
    agent = "copilot",
    context = "buffers",
    sticky = nil,
    temperature = 0.1,
    headless = false,
    system_prompt = require("CopilotChat.config.prompts").COPILOT_INSTRUCTIONS,
    window = {
        layout = "vertical",
        width = 0.4,
        height = 0.5,
        border = "rounded",
        title = "Copilot Chat",
    },
    mappings = {
        complete = { insert = "<Tab>" },
        close = { normal = "q", insert = "<C-c>" },
        reset = { normal = "<C-l>", insert = "<C-l>" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        toggle_sticky = { normal = "gr" },
        accept_diff = { normal = "<C-y>", insert = "<C-y>" },
        jump_to_diff = { normal = "gj" },
        quickfix_diffs = { normal = "gq" },
        yank_diff = { normal = "gy", register = '"' },
        show_diff = { normal = "gd" },
        show_info = { normal = "gi" },
        show_context = { normal = "gc" },
        show_help = { normal = "gh" },
    },
})

local map = vim.keymap.set

map("n", "<leader>aa", function()
    chat.toggle()
end, { desc = "Toggle Copilot Chat" })

map("n", "<leader>ae", function()
    chat.ask("Explain this code", { selection = require("CopilotChat.select").buffer })
end, { desc = "Explain code" })

map("n", "<leader>ar", function()
    chat.ask("Review this code for correctness, performance, and best practices", {
        selection = require("CopilotChat.select").buffer,
    })
end, { desc = "Review code" })

map("n", "<leader>af", function()
    chat.ask("Fix any bugs or issues in this code", {
        selection = require("CopilotChat.select").buffer,
    })
end, { desc = "Fix code" })

map("n", "<leader>at", function()
    chat.ask("Write tests for this code", {
        selection = require("CopilotChat.select").buffer,
    })
end, { desc = "Generate tests" })

map("n", "<leader>ao", function()
    chat.ask("Optimize this code for performance and readability", {
        selection = require("CopilotChat.select").buffer,
    })
end, { desc = "Optimize code" })

-- Visual mode: chat on selection
map("v", "<leader>aa", function()
    chat.ask("", { selection = require("CopilotChat.select").visual })
end, { desc = "Chat on selection" })

map("v", "<leader>ae", function()
    chat.ask("Explain this code", { selection = require("CopilotChat.select").visual })
end, { desc = "Explain selection" })
