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
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = keys,
    opts = {
      options = {
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "icon",
          -- style = "underline",
        },
        auto_toggle_bufferline = true,
        color_icons = true,
        -- separator_style = { "|", "|" },
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },
  {
    "neanias/everforest-nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }

      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(res)
            return res:sub(1, 1)
          end,
          icon = "",
        },
      }

      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          filename_hl = "Bold",
          modified_hl = "MatchParen",
          directory_hl = "Conceal",
        }),
      }
      local lsp = function()
        local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
        if #buf_clients == 0 then
          return ""
        end

        return " "
      end

      local formatter = function()
        local formatters = require("conform").list_formatters(0)
        if #formatters == 0 then
          return ""
        end

        return "󰛖 "
      end

      local linter = function()
        local linters = require("lint").linters_by_ft[vim.bo.filetype]
        -- local linters = require("lint").get_running()
        if #linters == 0 then
          return ""
        end

        return "󱉶 "
      end

      if vim.g.lualine_info_extras == true then
        table.insert(opts.sections.lualine_x, 2, lsp)
        table.insert(opts.sections.lualine_x, 2, formatter)
        table.insert(opts.sections.lualine_x, 2, linter)
      end
      opts.sections.lualine_y = { "progress" }
      opts.sections.lualine_z = {
        { "location", separator = "" },
        {
          function()
            return ""
          end,
          padding = { left = 0, right = 1 },
        },
      }
      opts.extensions = {
        "lazy",
        "man",
        "mason",
        "nvim-dap-ui",
        "overseer",
        "quickfix",
        "toggleterm",
        "trouble",
        "neo-tree",
        "symbols-outline",
      }
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[

 ▄████▄   ▒█████   ██▓     ██▓    ▄▄▄     ▄▄▄█████▓▒███████▒
▒██▀ ▀█  ▒██▒  ██▒▓██▒    ▓██▒   ▒████▄   ▓  ██▒ ▓▒▒ ▒ ▒ ▄▀░
▒▓█    ▄ ▒██░  ██▒▒██░    ▒██░   ▒██  ▀█▄ ▒ ▓██░ ▒░░ ▒ ▄▀▒░ 
▒▓▓▄ ▄██▒▒██   ██░▒██░    ▒██░   ░██▄▄▄▄██░ ▓██▓ ░   ▄▀▒   ░
▒ ▓███▀ ░░ ████▓▒░░██████▒░██████▒▓█   ▓██▒ ▒██▒ ░ ▒███████▒
░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░▓  ░░ ▒░▓  ░▒▒   ▓▒█░ ▒ ░░   ░▒▒ ▓░▒░▒
  ░  ▒     ░ ▒ ▒░ ░ ░ ▒  ░░ ░ ▒  ░ ▒   ▒▒ ░   ░    ░░▒ ▒ ░ ▒
░        ░ ░ ░ ▒    ░ ░     ░ ░    ░   ▒    ░      ░ ░ ░ ░ ░
░ ░          ░ ░      ░  ░    ░  ░     ░  ░          ░ ░    
░                                                  ░        

        ]],
        },
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Sessions", padding = 1 },
          { section = "projects", padding = 1 },
          { section = "keys", gap = 1 },
          { section = "startup" },
        },
      },
      lazygit = {
        configure = false,
      },
      notifier = {
        style = "fancy",
      },
      terminal = {
        win = {
          position = "bottom",
        },
      },
    },
  },
}
