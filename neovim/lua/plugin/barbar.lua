-- disable auto-setup
vim.g.barbar_auto_setup = false

local plugin = require 'barbar'

plugin.setup {
  animation = false,
  tabpages = false,
  icons = {
    filetype = {
      enabled = false
    },
    separator = { left = '', right = '' },
    separator_at_end = false,
    modified = { button = '*' }
  },
  sidebar_filetypes = {
    NvimTree = true,
  },
  no_name_title = '[anon buf]',
}

vim.api.nvim_set_hl(0, 'BufferCurrent', {})
vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = '#b35900' })
