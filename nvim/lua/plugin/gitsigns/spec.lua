return {
  'lewis6991/gitsigns.nvim',
  dev = true,

  event = 'VeryLazy',

  config = function()
    require 'plugin.gitsigns.cfg'
  end,
}
