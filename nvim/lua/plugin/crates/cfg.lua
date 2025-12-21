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

  popup = {
    text = {
      title = ' %s',
      pill_left = '',
      pill_right = '',
      created_label = ' created      ',
      updated_label = ' updated      ',
      downloads_label = ' downloads    ',
      homepage_label = ' homepage     ',
      repository_label = ' repo         ',
      documentation_label = ' docs         ',
      crates_io_label = ' crates.io    ',
      lib_rs_label = ' lib.rs       ',
      categories_label = ' categories   ',
      keywords_label = ' keywords     ',
    },
  },
}
