return {
  'm4xshen/autoclose.nvim',
  dev = true,

  keys = {
    { mode = 'n', ':' },
    { mode = 'n', '/' },
    { mode = 'n', '?' },
  },
  event = 'InsertEnter',

  config = function()
    require 'plugin.autoclose.cfg'
  end,
}
