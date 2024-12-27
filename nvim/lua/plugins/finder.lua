return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    {
      "<M-S-o>",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "Go to Symbol",
    },
  },
}
