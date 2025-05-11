return {
  'j-hui/fidget.nvim',
  dev = true,

  event = 'VeryLazy',

  config = function()
    require 'plugin.fidget.cfg'
  end,
}
