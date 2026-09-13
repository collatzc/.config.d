-- Mason 里的 oxfmt/oxlint 会被 mason-lspconfig automatic_enable 自动挂载，
-- oxfmt 用自身默认风格（双引号/分号/尾逗号）格式化，与项目 .prettierrc 冲突。
-- 显式禁用这两个 LSP，格式化统一走 conform + prettier（自动读取项目 .prettierrc）。
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxfmt = { enabled = false },
        oxlint = { enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        less = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
