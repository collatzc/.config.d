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
  { ".git", "lua", ".obsidian", "package.json", "Makefile", "go.mod", "Cargo.toml", "pyproject.toml", "src" },
  "cwd",
}

-- Disable annoying cmd line stuff
o.showcmd = false
o.laststatus = 3
o.cmdheight = 0

o.spell = false

if go.vscode then
  local vscode = require("vscode")
  vim.notify = vscode.notify
  o.cmdheight = 1
end

-- Backspacing and indentation when wrapping
o.backspace = { "start", "eol", "indent" }
o.breakindent = true

o.wrap = true

-- Smoothscroll
o.smoothscroll = true

o.conceallevel = 2

o.autoindent = true
o.shiftwidth = 2
o.tabstop = 2
o.listchars:append({ tab = "▸ ", trail = "·", extends = "❯", precedes = "❮" }) -- eol:»·,trail:·

o.title = true
o.titlelen = 0
o.list = true
o.titlestring = [[ %{fnamemodify(getcwd(), ':t')} %h%m%r%w]]
-- 深浅色由 auto-dark-mode.nvim 跟随系统切换，无需手动设 background

-- Icon for diagnostics (highlight line number instead of having icons in sign column)
vim.diagnostic.config({
  virtual_text = {
    prefix = " ",
  },
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  signs = {
    text = { [1] = " ", [2] = " ", [3] = " ", [4] = " " },
    numhl = {
      [1] = "DiagnosticSignError",
      [2] = "DiagnosticSignWarn",
      [3] = "DiagnosticSignInfo",
      [4] = "DiagnosticSignHint",
    },
  },
})
-- Show line diagnostics automatically in hover window
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--   group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
--   end,
-- })

-- WSL: Clipboard
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
