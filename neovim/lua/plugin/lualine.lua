local plugin = require 'lualine'

plugin.setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename', 'diagnostics' },
    lualine_x = { 'encoding', 'fileformat' },
    lualine_y = { 'searchcount', 'progress' },
    lualine_z = { 'location' },
  },
}
