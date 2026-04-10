local dap = require("dap")
local dapui = require("dapui")

-- UI setup
dapui.setup({
    icons = { expanded = "", collapsed = "", current_frame = "" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
        },
    },
    controls = {
        enabled = true,
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
            disconnect = "",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = { close = { "q", "<Esc>" } },
    },
    render = {
        max_type_length = nil,
        max_value_lines = 100,
    },
})

-- virtual text
require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    filter_references_pattern = "<module",
    virt_text_pos = "eol",
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil,
})

-- Auto open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Adapters
-- Python
dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
                return venv .. "/bin/python"
            end
            return "python"
        end,
    },
}

-- Rust/C/C++ via CodeLLDB
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}
dap.configurations.rust = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

-- Keymaps
local map = vim.keymap.set
map("n", "<F5>", dap.continue, { desc = "Debug: continue" })
map("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
map("n", "<F12>", dap.step_out, { desc = "Debug: step out" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })
map("n", "<leader>dl", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Log point" })
map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
map("n", "<leader>dL", dap.run_last, { desc = "Run last" })
map("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
map("n", "<leader>dx", dap.terminate, { desc = "Terminate" })
map({ "n", "v" }, "<leader>dh", require("dap.ui.widgets").hover, { desc = "Hover value" })
map({ "n", "v" }, "<leader>dp", require("dap.ui.widgets").preview, { desc = "Preview" })
map("n", "<leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end, { desc = "Stack frames" })
map("n", "<leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })
