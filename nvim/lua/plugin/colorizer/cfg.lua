local plugin = require 'colorizer'

plugin.setup {
  filetypes = {
    '*',
    '!fidget',
    '!strace',
    '!neo-tree',
  },
  user_default_options = {
    names    = false,
    rgb_fn   = true,
    hsl_fn   = true,
    RRGGBBAA = true,
    AARRGGBB = true,
  },
}
