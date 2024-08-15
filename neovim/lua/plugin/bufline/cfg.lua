local k = require 'infra.key'
local plugin = require 'bufferline'

plugin.setup {
  options = {
    show_buffer_icons = false,
    separator_style = { '', '' },
    indicator = { style = 'none' },
    modified_icon = ' 󰨓',
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

local function gc_buffers()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if
        ft == 'neo-tree' or
        ft == 'toggleterm'
    then
      goto continue
    end

    local info = vim.fn.getbufinfo(buf)[1]
    if
        info.listed == 0 and -- buffer is hidden
        info.changed == 0    -- and saved
    then
      vim.api.nvim_buf_delete(buf, {});
    end

    ::continue::
  end
end
-- close and gc other buffers
k.map('n', 'qo', function()
  vim.cmd 'BufferLineCloseOthers'
  vim.schedule(gc_buffers)
end)
