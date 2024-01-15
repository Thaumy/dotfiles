local plugin = require 'dashboard'

plugin.setup {
  config = {
    header   = {},
    center   = {},
    footer   = {},
    packages = { enable = false },
    shortcut = {
      {
        desc = "New",
        group = "_",
        key = 'n',
        action = function()
          vim.cmd "bd"
        end
      },
    },
  }
}
