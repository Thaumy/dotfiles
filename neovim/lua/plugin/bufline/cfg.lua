local k = require 'infra.keymap'
local plugin = require 'bufferline'

local neotree_modified_icon_color = string.format('#%x',
  vim.api.nvim_get_hl(0, { name = 'NeoTreeModified' }).fg
)

plugin.setup {
  options = {
    show_buffer_icons = false,
    separator_style = { '', '' },
    left_trunc_marker = '+',
    right_trunc_marker = '+',
    buffer_close_icon = '󰅖',
    offsets = {
      {
        filetype = 'neo-tree',
        separator = ''
      }
    },
    close_command = 'BufDel %d', -- use `BufDel` to fix weird behavior of closing active buffer
    right_mouse_command = ''
  },
  highlights = {
    modified = {
      fg = neotree_modified_icon_color,
    },
    modified_visible = {
      fg = neotree_modified_icon_color,
    },
    modified_selected = {
      fg = neotree_modified_icon_color,
    },
  }
}

-- cycle buffer R/L
k.map_cmd('n', '<M-;>', 'BufferLineCycleNext')
k.map_cmd('n', '<M-S-;>', 'BufferLineCyclePrev')
-- close buffer
k.map_cmd('n', '<M-x>', 'BufDel')
