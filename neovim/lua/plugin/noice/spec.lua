return {
  'folke/noice.nvim',
  dev = true,

  dependencies = {
    require 'plugin.nui.spec',
    require 'plugin.notify.spec',
  },

  event = 'VimEnter',

  config = function()
    require 'plugin.noice.cfg'
  end,
}
