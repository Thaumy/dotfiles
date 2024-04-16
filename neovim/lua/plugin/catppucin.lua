local plugin = require 'catppuccin'

local function setup_dark()
  plugin.setup {
    flavour = 'mocha',
    color_overrides = {
      all = {
        --surface1 = '#313240',
      },
    },
    custom_highlights = {
      BufferLineBufferSelected = { style = { 'bold' } },
      CurSearch = { fg = '#FFB5DA', bg = '#6420AA' },
    },
  }
end

local function setup_light()
  plugin.setup {
    flavour = 'latte',
    color_overrides = {
      all = {
        --surface1 = '#dbdbdb'
      },
    },
    custom_highlights = {
      BufferLineBufferSelected = { style = { 'bold' } },
      CurSearch = { fg = '#6420AA', bg = '#FFB5DA' },
    },
  }
end

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
  setup_light()
else
  setup_dark()
end

vim.cmd.colorscheme 'catppuccin'
