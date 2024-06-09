local k = require 'infra.key'
local plugin = require 'catppuccin'

plugin.setup {
  highlight_overrides = {
    latte = {
      CurSearch = { fg = '#6420AA', bg = '#FFB5DA' },
      CursorLine = { bg = '#fafafa' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      BufferLineBufferSelected = { style = { 'bold' } },
    },
    frappe = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#3a3f55' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      BufferLineBufferSelected = { style = { 'bold' } },
    },
    macchiato = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#2e324a' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      BufferLineBufferSelected = { style = { 'bold' } },
    },
    mocha = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#252636' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      BufferLineBufferSelected = { style = { 'bold' } },
    },
  },
}

local function is_light_theme()
  local cmd = 'dconf read /org/gnome/desktop/interface/color-scheme'
  local handle = io.popen(cmd)
  if handle == nil then return false end

  local theme = handle:read 'a'
  handle:close()
  if theme == "'light'\n" then
    return true
  end

  return false
end

if is_light_theme() then
  vim.cmd.colorscheme 'catppuccin-latte'
else
  vim.cmd.colorscheme 'catppuccin-mocha'
end

-- cycle colorscheme
local colorschemes = {
  'catppuccin-latte',
  'catppuccin-frappe',
  'catppuccin-macchiato',
  'catppuccin-mocha',
}
k.map('n', 'tl', function()
  local curr = vim.g.colors_name
  for i, it in ipairs(colorschemes) do
    if curr == it then
      vim.cmd.colorscheme(colorschemes[(i - 1) % 5])
      return
    end
  end
end)
k.map('n', 'td', function()
  local curr = vim.g.colors_name
  for i, it in ipairs(colorschemes) do
    if curr == it then
      vim.cmd.colorscheme(colorschemes[(i + 1) % 5])
      return
    end
  end
end)
