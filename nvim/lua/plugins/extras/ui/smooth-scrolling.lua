return {
  "declancm/cinnamon.nvim",
  enabled = false,
  event = "VeryLazy",
  config = function()
    local cinnamon = require("cinnamon")

    cinnamon.setup({
      options = {
        delay = 6,
      },
    })

    local keymaps = {
      ["<C-u>"] = "<C-u>zz",
      ["<C-d>"] = "<C-d>zz",
      ["n"] = "nzzzv",
      ["N"] = "Nzzzv",
    }

    for key, value in pairs(keymaps) do
      vim.keymap.set("n", key, function()
        cinnamon.scroll(value)
      end)
    end

    -- Flash.nvim integration:
    local flash = require("flash")
    local jump = require("flash.jump")

    flash.setup({
      action = function(match, state)
        cinnamon.scroll(function()
          jump.jump(match, state)
          jump.on_jump(state)
        end)
      end,
    })
  end,
}
