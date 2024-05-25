return {
  'nvim-telescope/telescope.nvim',
  dev = true,

  dependencies = {
    require 'plugin.nui.spec',
    require 'plugin.plenary.spec',
  },

  event = 'VimEnter',

  config = function()
    require 'plugin.telescope.cfg'
  end,
}
