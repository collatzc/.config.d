-- vtsls 默认给 tsserver 的 V8 堆上限是 3072MB（VS Code 同款默认值），
-- erp.webapp 这类大型前端项目挂上 @vue/typescript-plugin 后加载即超限，
-- tsserver 反复 SIGABRT 崩溃（"service crashed 5 times" 就是它）。
-- 这里放宽到 4GB（默认 3072MB 略紧）；上限只是封顶值，不预占内存。
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 4096,
            },
          },
        },
      },
    },
  },
}
