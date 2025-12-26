return {
  'nvim-mini/mini.pairs',
  dev = true,

  keys = {
    { mode = 'n', ':' },
    { mode = 'n', '/' },
    { mode = 'n', '?' },
  },
  event = 'InsertEnter',

  config = function()
    require 'plugin.mini-pairs.cfg'
  end,
}
