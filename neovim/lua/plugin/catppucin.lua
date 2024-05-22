local plugin = require 'catppuccin'

local dark = {
  flavour = 'mocha',
  custom_highlights = {
    BufferLineBufferSelected = { style = { 'bold' } },
    CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
    CursorLine = { bg = '#252636' },
  },
}

local light = {
  flavour = 'latte',
  custom_highlights = {
    BufferLineBufferSelected = { style = { 'bold' } },
    CurSearch = { fg = '#6420AA', bg = '#FFB5DA' },
    CursorLine = { bg = '#fafafa' },
  },
}

local function is_light_theme()
  local cmd = 'dconf read /org/gnome/desktop/interface/color-scheme'
  local handle = io.popen(cmd)

  if handle == nil then
    return false
  end

  local theme = handle:read('*a')
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
