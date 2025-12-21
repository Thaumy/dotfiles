local plugin = require 'gitsigns'

plugin.setup {
  numhl                           = true,
  signcolumn                      = false,
  auto_attach                     = true,
  attach_to_untracked             = false,
  current_line_blame              = true,
  current_line_blame_opts         = {
    virt_text = true,
    virt_text_pos = 'right_align',
    delay = 400,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  -- committed blame
  current_line_blame_formatter    = function(_, info)
    local fmt = info.author .. '(<author_time:%y-%m-%d>): <summary>'
    local text = require 'gitsigns.util'.expand_format(fmt, info)
    return { { text, 'GitSignsCurrentLineBlame' } }
  end,
  -- not committed blame
  current_line_blame_formatter_nc = '',
}
