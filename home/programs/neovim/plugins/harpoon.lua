local harpoon = require("harpoon")

harpoon:setup({
    settings = {
        save_on_toggle = false,
        sync_on_ui_close = false,
        key = function()
            return vim.uv.cwd()
        end,
    },
})

local map = vim.keymap.set

-- Add / open list
map("n", "<leader>ha", function()
    harpoon:list():add()
end, { desc = "Harpoon add file" })
map("n", "<leader>hh", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })

-- Quick jump to marks 1-5
map("n", "<leader>h1", function()
    harpoon:list():select(1)
end, { desc = "Harpoon file 1" })
map("n", "<leader>h2", function()
    harpoon:list():select(2)
end, { desc = "Harpoon file 2" })
map("n", "<leader>h3", function()
    harpoon:list():select(3)
end, { desc = "Harpoon file 3" })
map("n", "<leader>h4", function()
    harpoon:list():select(4)
end, { desc = "Harpoon file 4" })
map("n", "<leader>h5", function()
    harpoon:list():select(5)
end, { desc = "Harpoon file 5" })

-- Cycle prev/next
map("n", "<leader>hp", function()
    harpoon:list():prev()
end, { desc = "Harpoon prev" })
map("n", "<leader>hn", function()
    harpoon:list():next()
end, { desc = "Harpoon next" })

-- Telescope integration
local conf = require("telescope.config").values
map("n", "<leader>fe", function()
    local file_paths = {}
    for _, item in ipairs(harpoon:list().items) do
        table.insert(file_paths, item.value)
    end
    require("telescope.pickers")
        .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({ results = file_paths }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        })
        :find()
end, { desc = "Find harpoon files" })
