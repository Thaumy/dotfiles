return {
  'numToStr/comment.nvim',
  dev = true,

  keys = {
    { mode = 'n', 'm' },
    { mode = 'n', 'bm' },
    { mode = 'v', 'm' },
    { mode = 'v', 'bm' },
  },

  config = function()
    require 'plugin.comment.cfg'
  end,
}
