return {
  'nvim-telescope/telescope.nvim',
  dev = true,

  dependencies = {
    require 'plugin.nui.spec',
    require 'plugin.plenary.spec',
  },

  cmd = 'Telescope',
  keys = {
    { mode = 'n', 'tm' },
    { mode = 'n', 'g/' },
    { mode = 'n', 'fd' },
    { mode = 'n', '<M-d>' },
    { mode = 'n', '<M-u>' },
    { mode = 'n', '<M-i>' },
  },

  config = function()
    require 'plugin.telescope.cfg'
  end,
}
