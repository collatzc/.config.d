local palette = require("catppuccin.palettes").get_palette("mocha") -- Import your favorite catppuccin colors

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      styles = {
        comments = { "italic" },
      },
      flavour = "macchiato",
      background = {
        light = "latte",
        dark = "mocha",
      },
      dim_inactive = {
        enable = true,
        shade = "dark",
        percentage = 0.2,
      },
      term_colors = true,
      integrations = {
        alpha = true,
        cmp = true,
        blink_cmp = true,
        colorful_winsep = {
          enabled = true,
          color = "lavender",
        },
        dap = true,
        dap_ui = true,
        dashboard = true,
        diffview = true,
        flash = true,
        headlines = true,
        gitsigns = true,
        grug_far = true,
        harpoon = false,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        render_markdown = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "italic" },
          },
          inlay_hints = {
            background = false,
          },
        },
        lsp_trouble = true,
        navic = { enabled = false, custom_bg = "lualine" },
        neotest = true,
        neogit = false,
        neotree = true,
        notify = true,
        noice = true,
        ufo = true,
        overseer = false,
        octo = false,
        rainbow_delimiters = true,
        semantic_tokens = true,
        snacks = true,
        telescope = {
          enabled = true,
        },
        symbols_outline = false,
        treesitter = true,
        treesitter_context = false,
        which_key = true,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
          all = {
            -- fill = {
            --   bg = palette.mantle,
            -- },
            separator_selected = {
              bg = palette.base,
              fg = palette.mantle,
            },
            -- separator = {
            --   bg = palette.base,
            --   fg = palette.mantle,
            -- },
            tab_separator = {
              bg = palette.base,
              fg = palette.mantle,
            },
            tab_selected = {
              bg = palette.base,
            },
            tab_separator_selected = {
              bg = palette.base,
              fg = palette.mantle,
            },
          },
        },
      }),
    },
  },
  {
    "rasulomaroff/reactive.nvim",
    optional = true,
    opts = {
      load = { "catppuccin-macchiato-cursor", "catppuccin-macchiato-cursorline" },
    },
  },
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    optional = true,
    opts = {
      colors = palette,
      factors = {
        lightness = 0.9,
        chroma = 1,
        hue = 0.7,
      },
    },
  },
}
