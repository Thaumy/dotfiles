local k = require 'infra.key'
local plugin = require 'bufferline'

plugin.setup {
  options = {
    show_buffer_icons = false,
    separator_style = { '', '' },
    left_trunc_marker = '+',
    right_trunc_marker = '+',
    buffer_close_icon = '',
    right_mouse_command = 'BufDel %d', -- use `BufDel` to fix weird behavior of closing active buffer
    style_preset = plugin.style_preset.no_italic,
  },
  highlights = require 'catppuccin.groups.integrations.bufferline'.get(),
}

-- cycle bufs
k.map_cmd('n', '<M-;>', 'BufferLineCycleNext')
k.map_cmd('n', '<M-p>', 'BufferLineCyclePrev')

-- close other bufs
k.map_cmd('n', 'qo', 'BufferLineCloseOthers')
