return {
  'RRethy/vim-illuminate',
  dev = true,

  event = 'BufRead',

  config = function()
    require 'plugin.illuminate.cfg'
  end,
}
