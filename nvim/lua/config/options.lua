local go = vim.g
local o = vim.opt

-- Optimizations on startup
vim.loader.enable()

-- Personal Config and LazyVim global options
go.lualine_info_extras = true
go.codeium_cmp_hide = false
go.lazygit_config = false

-- Define leader key
go.mapleader = " "
go.maplocalleader = "\\"

-- Autoformat on save (Global)
go.autoformat = true

-- Font
go.gui_font_default_size = 12
go.gui_font_size = go.gui_font_default_size
go.gui_font_face = "Maple Mono NF CN"

-- Enable EditorConfig integration
go.editorconfig = true

-- Root dir detection
go.root_spec = {
  "lsp",
  { ".git", "lua", ".obsidian", "package.json", "Makefile", "go.mod", "cargo.toml", "pyproject.toml", "src" },
  "cwd",
}

go.floaterm_height = 0.3
go.floaterm_position = "bottom"

-- Disable annoying cmd line stuff
o.showcmd = false
o.laststatus = 3
o.cmdheight = 0

-- Enable spell checking
o.spell = true
o.spelllang:append("en_us")

-- Backspacing and indentation when wrapping
o.backspace = { "start", "eol", "indent" }
o.breakindent = true

o.wrap = true

-- Smoothscroll
if vim.fn.has("nvim-0.10") == 1 then
  o.smoothscroll = true
end

o.conceallevel = 2

o.autoindent = true
o.shiftwidth = 2
o.tabstop = 2
o.listchars:append({ tab = "▸ ", trail = "·", extends = "❯", precedes = "❮" }) -- eol:»·,trail:·

o.title = true
o.titlelen = 0

o.list = true
o.titlestring = [[ %{v:progname} %{fnamemodify(getcwd(), ':t')} %h%m%r%w]]

-- Icon for diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = " ",
  },
  severity_sort = true,
  underline = true,
  update_in_insert = false,
})

-- Highlight line number instead of having icons in sign column
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
  vim.fn.sign_define("DiagnosticSign" .. diag, {
    text = signs[diag],
    texthl = "DiagnosticSign" .. diag,
    linehl = "",
    numhl = "DiagnosticSign" .. diag,
  })
end
-- Show line diagnostics automatically in hover window
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
  end,
})

-- Colorscheme
go.everforest_background = "soft"
go.everforest_better_performance = 1
go.everforest_cursor = "orange"
go.everforest_dim_inactive_windows = 1