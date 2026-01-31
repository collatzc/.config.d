local keys = {}

for i = 1, 9 do
  table.insert(keys, { "<M-" .. i .. ">", "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", desc = "Buffer " .. i })
end

table.insert(keys, { "<leader>.", "<cmd>BufferLinePick<CR>", desc = "Pick Buffer" })

table.insert(keys, { "<leader>bS", "<Cmd>BufferLineSortByDirectory<CR>", desc = "Sort By Directory" })
table.insert(keys, { "<leader>bs", "<Cmd>BufferLineSortByExtension<CR>", desc = "Sort By Extensions" })

table.insert(keys, { "<space><", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" })
table.insert(keys, { "<space>>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" })

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
    config = function()
      require("everforest").setup({
        background = "soft",
        transparent_background_level = 2,
        italics = true,
        ui_contrast = "low",
        dim_inactive_windows = true,
        float_style = "dim",
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        functions = { italic = false, blend = 33 },
        variables = { bold = true, italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
      dim_inactive = true,
      on_highlights = function(hl, c)
        hl.LineNr = {
          fg = vim.o.background == "light" and c.comment or c.fg_gutter,
        }
        hl.LineNrAbove = hl.LineNr
        hl.LineNrBelow = hl.LineNr
        hl.LspInlayHint = {}
        hl.Comment = {
          fg = vim.o.background == "light" and c.comment or c.fg_dark,
        }
      end,
    },
  },
  --   return {
  --   bg = "#222436",
  --   bg_dark = "#1e2030",
  --   bg_dark1 = "#191B29",
  --   bg_highlight = "#2f334d",
  --   blue = "#82aaff",
  --   blue0 = "#3e68d7",
  --   blue1 = "#65bcff",
  --   blue2 = "#0db9d7",
  --   blue5 = "#89ddff",
  --   blue6 = "#b4f9f8",
  --   blue7 = "#394b70",
  --   comment = "#636da6",
  --   cyan = "#86e1fc",
  --   dark3 = "#545c7e",
  --   dark5 = "#737aa2",
  --   fg = "#c8d3f5",
  --   fg_dark = "#828bb8",
  --   fg_gutter = "#3b4261",
  --   green = "#c3e88d",
  --   green1 = "#4fd6be",
  --   green2 = "#41a6b5",
  --   magenta = "#c099ff",
  --   magenta2 = "#ff007c",
  --   orange = "#ff966c",
  --   purple = "#fca7ea",
  --   red = "#ff757f",
  --   red1 = "#c53b53",
  --   teal = "#4fd6be",
  --   terminal_black = "#444a73",
  --   yellow = "#ffc777",
  --   git = {
  --     add = "#b8db87",
  --     change = "#7ca1f2",
  --     delete = "#e26a75",
  --   },
  -- }
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      transparent_background = false,
      styles = {
        variables = { "bold", "italic" },
      },
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 60000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
      end,
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
          { icon = " ", title = "Sessions", padding = 1 },
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
        -- win = {
        --   style = "terminal",
        -- },
      },
    },
    keys = {
      {
        "<leader>lg",
        function()
          require("snacks").lazygit()
        end,
        desc = "LazyGit",
      },
      {
        "<leader>gl",
        function()
          require("snacks").lazygit.log()
        end,
        desc = "LazyGit Log",
      },
      {
        "<leader>gbb",
        function()
          require("snacks").picker.git_branches({ layout = "select" })
        end,
        desc = "Git Branches",
      },
      {
        "<leader>es",
        function()
          require("snacks").explorer()
        end,
        desc = "Snacks Explorer",
      },
    },
  },
  {
    "tadaa/vimade",
    event = "VeryLazy",
    opts = {
      recipe = { "paradox", { animate = true } },
      ncmode = "windows",
      invert = {
        start = 0,
        to = 0.8,
      },
      -- tint = {
      --   fg = {
      --     intensity = 0.3,
      --   },
      -- },
    },
  },
  -- {
  --   "levouh/tint.nvim",
  --   config = function()
  --     local tint = vim.o.background == "light" and 100 or -90
  --     require("tint").setup({
  --       -- tint = vim.o.background == "light" and 45 or -45, -- Darken colors, use a positive value to brighten
  --       -- tint = 45, -- Darken colors, use a positive value to brighten
  --       transforms = {
  --         require("tint.transforms").tint_with_threshold(tint, "#D1D1D1", 150),
  --       },
  --       tint_background_colors = false, -- Tint background portions of highlight groups
  --       highlight_ignore_patterns = { "WinSeparator", "Status.*", "lualine.*" }, -- Highlight group patterns to ignore, see `string.find`
  --     })
  --   end,
  -- },
}
