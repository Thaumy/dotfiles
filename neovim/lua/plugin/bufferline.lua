local plugin = require 'bufferline'

plugin.setup {
  options = {
    show_buffer_icons = false,
    separator_style = { '', '' },
    left_trunc_marker = '+',
    right_trunc_marker = '+',
    offsets = {
      {
        filetype = "neo-tree",
        separator = ''
      }
    }
  }
}
