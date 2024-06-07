local plugin = require 'illuminate'

plugin.configure {
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  delay = 100,
  large_file_cutoff = 20000,
  filetypes_denylist = {},
}
