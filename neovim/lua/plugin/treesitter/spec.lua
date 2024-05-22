return {
  'nvim-treesitter/nvim-treesitter',
  dev = true,

  dependencies = {
    require 'plugin.ibl.spec',
    require 'plugin.rainbow-deli.spec',
  },

  event = 'BufRead',

  config = function()
    require 'plugin.treesitter.cfg'
  end,
}
