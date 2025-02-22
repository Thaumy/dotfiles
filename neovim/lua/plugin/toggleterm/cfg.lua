local k = require 'infra.key'
local plugin = require 'toggleterm'

local border_color = string.format('#%x',
  vim.api.nvim_get_hl(0, { name = 'FloatBorder' }).fg
)

plugin.setup {
  direction = 'float',
  highlights = {
    FloatBorder = {
      guifg = border_color,
    },
  },
}

-- toggle if vim not in toggleterm
if os.getenv 'TERM' ~= 'xterm-256color' then
  k.map('n', 'tt', function()
    vim.cmd 'ToggleTerm'
  end)
end
k.map_cmd('t', '<Esc>', 'ToggleTerm')
