local plugin = require 'toggleterm'

local border_color = string.format('#%x',
  vim.api.nvim_get_hl(0, { name = 'FloatBorder' }).fg
)

plugin.setup {
  direction = 'float',
  highlights = {
    FloatBorder = {
      guifg = border_color
    },
  }
}
