local plugin = require 'catppuccin'

local function setup_dark()
  plugin.setup {
    flavour = "mocha",
    color_overrides = {
      all = {
        --surface1 = "#313240",
      },
    },
  }
end

local function setup_light()
  plugin.setup {
    flavour = "latte",
    color_overrides = {
      all = {
        --surface1 = "#dbdbdb"
      },
    },
  }
end

local function is_dark_theme()
  local cmd = 'dconf read /org/gnome/desktop/interface/color-scheme'
  local handle = io.popen(cmd)

  if (handle == nil) then
    return false
  end

  local theme = handle:read('*a')
  handle:close()
  if (string.find(theme, 'dark')) then
    return true
  end

  return false
end

if (is_dark_theme()) then
  setup_dark()
else
  setup_light()
end

vim.cmd.colorscheme "catppuccin"
