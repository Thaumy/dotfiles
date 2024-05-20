local plugin = require 'lualine'

plugin.setup {
  options = {
    icons_enabled = false,
    colorscheme = 'catppuccin',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'neo-tree' }
  },
}
