return {
  { import = "lazyvim.plugins.extras.ui.dashboard" },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[

  ___  __   __    __     __  ____  ____ 
 / __)/  \ (  )  (  )   / _\(_  _)(__  )
( (__(  O )/ (_/\/ (_/\/    \ )(   / _/ 
 \___)\__/ \____/\____/\_/\_/(__) (____)

      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      return opts
    end,
  },
}
