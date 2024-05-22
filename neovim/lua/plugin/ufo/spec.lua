return {
  'kevinhwang91/nvim-ufo',
  dev = true,

  dependencies = {
    require 'plugin.promise-async.spec',
  },

  event = 'BufEnter',

  config = function()
    require 'plugin.ufo.cfg'
  end,
}
