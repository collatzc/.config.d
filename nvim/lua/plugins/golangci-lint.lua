-- nvim-lint 已不再支持函数形式的 linter.cwd（函数会被原样传给 vim.cmd.cd，
-- 报 "Invalid 'args': Cannot convert given Lua type"）。
-- 但 linter 定义本身可以是函数，try_lint 每次运行时会对它求值，
-- 所以在这里动态计算项目根，返回带字符串 cwd 的定义。
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
      golangcilint = function()
        local linter = require("lint.linters.golangcilint")
        local file = vim.api.nvim_buf_get_name(0)
        if file ~= "" then
          linter.cwd = vim.fs.root(file, {
            "go.mod",
            "go.work",
            ".golangci.yml",
            ".golangci.yaml",
            ".golangci.toml",
            ".golangci.json",
            ".git",
          }) or vim.fn.getcwd()
        else
          linter.cwd = vim.fn.getcwd()
        end
        return linter
      end,
    },
  },
}
