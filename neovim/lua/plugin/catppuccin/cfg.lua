local k = require 'infra.key'
local plugin = require 'catppuccin'

plugin.setup {
  highlight_overrides = {
    latte = {
      CurSearch = { fg = '#6420AA', bg = '#FFB5DA' },
      CursorLine = { bg = '#fafafa' },
      TrailingSpace = { bg = '#ffc800' },
      NeoTreeGitConflict = { fg = '#ed1b24' },
      NeoTreeGitUntracked = { fg = '#40a02b' },
      GitConflictSepMark = { fg = '#19b9e7', bg = '#dcf4fb' },
      GitConflictBoundMark = { fg = '#ed1b24', bg = '#fbd1d3' },
      BufferLineBufferSelected = { style = { 'bold' } },
      ['@variable.builtin'] = { fg = '#1182a2' },
    },
    frappe = {
      CurSearch = { fg = '#6420AA', bg = '#FFB5DA' },
      CursorLine = { bg = '#dddddd' },
      TrailingSpace = { bg = '#ffc800' },
      NeoTreeGitConflict = { fg = '#ed1b24' },
      NeoTreeGitUntracked = { fg = '#40a02b' },
      GitConflictSepMark = { fg = '#19b9e7', bg = '#dcf4fb' },
      GitConflictBoundMark = { fg = '#ed1b24', bg = '#fbd1d3' },
      BufferLineBufferSelected = { style = { 'bold' } },
      ['@variable.builtin'] = { fg = '#1182a2' },
    },
    macchiato = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#2e324a' },
      TrailingSpace = { bg = '#ffc800' },
      NeoTreeGitConflict = { fg = '#e65d5a' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      GitConflictSepMark = { fg = '#16abd6', bg = '#041d24' },
      GitConflictBoundMark = { fg = '#e65d5a', bg = '#270706' },
      BufferLineBufferSelected = { style = { 'bold' } },
      ['@variable.builtin'] = { fg = '#16d4d1' },
    },
    mocha = {
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
      CursorLine = { bg = '#252636' },
      TrailingSpace = { bg = '#ffc800' },
      NeoTreeGitConflict = { fg = '#e65d5a' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      GitConflictSepMark = { fg = '#16abd6', bg = '#020f13' },
      GitConflictBoundMark = { fg = '#e65d5a', bg = '#160403' },
      BufferLineBufferSelected = { style = { 'bold' } },
      ['@variable.builtin'] = { fg = '#16d4d1' },
    },
  },
  color_overrides = {
    latte = {
      maroon = '#1182a2',
    },
    frappe = {
      rosewater = '#dc8a78',
      flamingo = '#dd7878',
      pink = '#ea76cb',
      mauve = '#8839ef',
      red = '#d20f39',
      peach = '#fe640b',
      yellow = '#df8e1d',
      green = '#40a02b',
      teal = '#179299',
      sky = '#04a5e5',
      sapphire = '#209fb5',
      blue = '#1e66f5',
      lavender = '#7287fd',
      text = '#4c4f69',
      subtext1 = '#5c5f77',
      subtext0 = '#6c6f85',
      overlay2 = '#7c7f93',
      overlay1 = '#8c8fa1',
      overlay0 = '#9ca0b0',
      surface2 = '#acb0be',
      surface1 = '#bcc0cc',
      surface0 = '#ccd0da',
      -- colors not from latte
      maroon = '#1182a2',
      base = '#f5f3ef',
      mantle = '#efece6',
      crust = '#e8e4dc',
    },
    macchiato = {
      maroon = '#16d4d1',
    },
    mocha = {
      maroon = '#16d4d1',
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
