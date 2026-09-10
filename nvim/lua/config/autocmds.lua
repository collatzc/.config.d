-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 系统深浅色切换(auto-dark-mode 改 background)或配色重载后,
-- 强制 lualine 全量重建状态栏高亮。否则新旧主题的格子会混在一起,
-- 表现为 powerline 分隔符和相邻色块颜色对不上(色差)。
local lualine_refresh_grp = vim.api.nvim_create_augroup("lualine_refresh_on_theme_change", { clear = true })
local function refresh_lualine()
  vim.schedule(function()
    local ok, lualine = pcall(require, "lualine")
    if ok then
      lualine.refresh({ place = { "statusline" }, scope = "all" })
    end
  end)
end
vim.api.nvim_create_autocmd("ColorScheme", { group = lualine_refresh_grp, callback = refresh_lualine })
vim.api.nvim_create_autocmd("OptionSet", { group = lualine_refresh_grp, pattern = "background", callback = refresh_lualine })
