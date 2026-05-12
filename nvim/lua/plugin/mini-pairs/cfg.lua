local plugin = require 'mini.pairs'

plugin.setup {
  modes = { insert = true, command = true, terminal = false },
  mappings = {
    ["'"] = {
      action = 'closeopen',
      pair = "''",
      neigh_pattern = '^[^\\<&]',
      register = { cr = false },
    },
  },
}
