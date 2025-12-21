return {
  'nvim-neo-tree/neo-tree.nvim',
  dev = true,

  dependencies = {
    require 'plugin.nui.spec',
    require 'plugin.plenary.spec',
    require 'plugin.web-devicons.spec',
  },

  event = 'VimEnter',

  config = function()
    require 'plugin.neo-tree.cfg'
  end,
}
