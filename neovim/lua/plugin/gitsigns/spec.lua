return {
  'lewis6991/gitsigns.nvim',
  dev = true,

  event = 'BufRead',

  config = function()
    require 'plugin.gitsigns.cfg'
  end,
}
