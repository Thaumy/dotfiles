return {
  'akinsho/toggleterm.nvim',
  dev = true,

  keys = {
    { mode = 'n', 't' },
  },

  config = function()
    require 'plugin.toggleterm.cfg'
  end,
}
