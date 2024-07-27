local plugin = require 'colorizer'

plugin.setup {
  filetypes = {
    '*',
    '!fidget',
    '!neo-tree',
  },
  user_default_options = {
    RRGGBBAA = true,
    AARRGGBB = true,
    rgb_fn = true,
    hsl_fn = true,
  },
}
