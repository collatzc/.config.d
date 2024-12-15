return {
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
}
