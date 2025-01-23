return {
  'Thaumy/git-messenger.vim',
  dev = true,

  keys = {
    { mode = 'n', 'b' },
  },

  config = function()
    require 'plugin.git-messenger.cfg'
  end,
}
