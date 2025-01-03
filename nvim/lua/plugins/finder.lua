return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    {
      "<leader><space><space>",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "Go to Symbol",
    },
  },
}
