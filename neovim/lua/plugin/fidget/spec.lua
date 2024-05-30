return {
  'j-hui/fidget.nvim',
  dev = true,

  event = 'VimEnter',

  config = function()
    require 'plugin.fidget.cfg'
  end,
}
