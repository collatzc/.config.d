-- ~/.config/nvim/lua/plugins/golangci-lint.lua
return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}

      opts.linters_by_ft.go = { "golangcilint" }
      opts.linters_by_ft.gomod = { "golangcilint" }
      opts.linters_by_ft.gowork = { "golangcilint" }
      opts.linters_by_ft.gotmpl = { "golangcilint" }
    end,
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      lint.linters.golangcilint.cwd = function()
        local file = vim.api.nvim_buf_get_name(0)

        if file == "" then
          return vim.fn.getcwd()
        end

        local root = vim.fs.root(file, {
          "go.mod",
          "go.work",
          ".golangci.yml",
          ".golangci.yaml",
          ".golangci.toml",
          ".golangci.json",
          ".git",
        })

        if root == nil then
          vim.schedule(function()
            vim.notify(
              "golangci-lint: cannot find go.mod/go.work/.golangci config/.git from current file, fallback to cwd: "
                .. vim.fn.getcwd(),
              vim.log.levels.WARN
            )
          end)

          return vim.fn.getcwd()
        end

        return root
      end
    end,
  },
}
