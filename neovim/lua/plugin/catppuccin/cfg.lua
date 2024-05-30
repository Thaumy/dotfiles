local plugin = require 'catppuccin'

local dark = {
  flavour = 'mocha',
  custom_highlights = {
    CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
    CursorLine = { bg = '#252636' },
    NeoTreeGitConflict = { fg = '#ff8700' },
    NeoTreeGitUntracked = { fg = '#83c66d' },
    BufferLineBufferSelected = { style = { 'bold' } },
  },
}

local light = {
  flavour = 'latte',
  custom_highlights = {
    CurSearch = { fg = '#6420AA', bg = '#FFB5DA' },
    CursorLine = { bg = '#fafafa' },
    NeoTreeGitConflict = { fg = '#ff8700' },
    NeoTreeGitUntracked = { fg = '#83c66d' },
    BufferLineBufferSelected = { style = { 'bold' } },
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
  plugin.setup(light)
else
  plugin.setup(dark)
end

vim.cmd.colorscheme 'catppuccin'
