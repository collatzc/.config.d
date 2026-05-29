return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    {
      "<leader>O",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "Go to Symbol",
    },
  },
}
