return {
  'terrortylor/nvim-comment',
  dev = true,

  keys = {
    { mode = 'v', 'm' },
  },

  config = function()
    require 'plugin.comment.cfg'
  end,
}
