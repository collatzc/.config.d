local keys = {}

for i = 1, 9 do
  table.insert(keys, { "<M-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", desc = "Buffer " .. i })
end

table.insert(keys, { "<leader>.", "<cmd>BufferLinePick<CR>", desc = "Pick Buffer" })

table.insert(keys, { "<leader>bS", "<Cmd>BufferLineSortByDirectory<CR>", desc = "Sort By Directory" })
table.insert(keys, { "<leader>bs", "<Cmd>BufferLineSortByExtension<CR>", desc = "Sort By Extensions" })

table.insert(keys, { "<space><", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" })
table.insert(keys, { "<space>>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" })

table.insert(keys, { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Tab" })
table.insert(keys, { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Tab" })

return {
  "akinsho/bufferline.nvim",
  optional = true,
  event = "VeryLazy",
  keys = keys,
  opts = {
    options = {
      indicator = {
        -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
        -- style = "icon",
        style = "underline",
      },
      auto_toggle_bufferline = true,
      color_icons = true,
      separator_style = "thick",
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
}
