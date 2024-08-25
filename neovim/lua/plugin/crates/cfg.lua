local plugin = require 'crates'

plugin.setup {
  lsp = {
    enabled = true,
    hover = true,
    actions = true,
    completion = true,
  },

  completion = {
    cmp = {
      use_custom_kind = true,
      kind_text = {
        version = 'v',
        feature = '󰐕',
      },
    },
  },

  text = {
    searching = ' searching ',
    loading = '..',
    version = ' %s ',
    prerelease = ' %s ',
    yanked = ' %s ',
    nomatch = '',
    upgrade = ' %s ',
    error = 'error fetching crate',
  },
}
