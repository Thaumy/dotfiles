local plugin = require 'rainbow-delimiters.setup'

plugin.setup {
  highlight = {
    'RainbowDelimiterGreen',
    'RainbowDelimiterBlue',
    'RainbowDelimiterCyan',
    'RainbowDelimiterViolet',
    'RainbowDelimiterYellow',
    'RainbowDelimiterOrange',
  },
  condition = function()
    return vim.api.nvim_buf_line_count(0) < 30000
  end,
}
