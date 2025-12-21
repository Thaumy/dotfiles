return {
  'numToStr/comment.nvim',
  dev = true,

  keys = {
    { mode = 'n', 'm' },
    { mode = 'n', 'cm' },
    { mode = 'x', 'm' },
    { mode = 'x', 'cm' },
  },

  config = function()
    require 'plugin.comment.cfg'
  end,
}
