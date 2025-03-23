local plugin = require 'autoclose'

plugin.setup {
  keys = {
    ['`'] = { escape = true, close = false, pair = '``' },
  },
  options = {
    disable_when_touch = true,
    pair_spaces = true,
    auto_indent = true,
  },
}
