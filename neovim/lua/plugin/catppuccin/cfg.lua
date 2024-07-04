local k = require 'infra.key'
local plugin = require 'catppuccin'

plugin.setup {
  color_overrides = {
    latte = {
      maroon = '#1182a2',
    },
    frappe = {
      maroon = '#16d4d1',
    },
    macchiato = {
      maroon = '#16d4d1',
    },
    mocha = {
      maroon = '#16d4d1',
    },
  },
  highlight_overrides = {
    latte = {
      CurSearch = { fg = '#6420AA', bg = '#FFB5DA' },
      CursorLine = { bg = '#fafafa' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#40a02b' },
      BufferLineBufferSelected = { style = { 'bold' } },
      TrailingWhitespace = { bg = '#ffc800' },
    },
    frappe = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#3a3f55' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      BufferLineBufferSelected = { style = { 'bold' } },
      TrailingWhitespace = { bg = '#ffc800' },
    },
    macchiato = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#2e324a' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      BufferLineBufferSelected = { style = { 'bold' } },
      TrailingWhitespace = { bg = '#ffc800' },
    },
    mocha = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#252636' },
      NeoTreeGitConflict = { fg = '#ff8700' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      BufferLineBufferSelected = { style = { 'bold' } },
      TrailingWhitespace = { bg = '#ffc800' },
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

local rev
if is_light_theme() then
  rev = false
  vim.cmd.colorscheme 'catppuccin-latte'
else
  rev = true
  vim.cmd.colorscheme 'catppuccin-mocha'
end

-- cycle colorscheme
local colorschemes = {
  'catppuccin-latte',
  'catppuccin-frappe',
  'catppuccin-macchiato',
  'catppuccin-mocha',
}
k.map('n', 'ts', function()
  local curr = vim.g.colors_name
  for i, it in ipairs(colorschemes) do
    if curr == it then
      if i == 1 or i == 4 then rev = not rev end
      if rev then
        vim.cmd.colorscheme(colorschemes[i - 1])
      else
        vim.cmd.colorscheme(colorschemes[i + 1])
      end
      return
    end
  end
end)
