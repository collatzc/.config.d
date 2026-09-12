return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
      gomod = { "golangcilint" },
      gowork = { "golangcilint" },
      gotmpl = { "golangcilint" },
    },
    linters = {
      golangcilint = {
        cwd = function()
          local file = vim.api.nvim_buf_get_name(0)
          if file == "" then
            return vim.fn.getcwd()
          end

          return vim.fs.root(file, {
            "go.mod",
            "go.work",
            ".golangci.yml",
            ".golangci.yaml",
            ".golangci.toml",
            ".golangci.json",
            ".git",
          }) or vim.fn.getcwd()
        end,
      },
    },
  },
}
