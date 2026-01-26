return {
  'Thaumy/git-messenger.vim',
  dev = true,

  keys = {
    { mode = 'n', 'bl' },
  },

  config = function()
    require 'plugin.git-messenger.cfg'
  end,
}
