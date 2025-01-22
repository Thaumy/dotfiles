return {
  'numToStr/comment.nvim',
  dev = true,

  keys = {
    { mode = 'n', 'm' },
    { mode = 'n', 'cm' },
    { mode = 'v', 'm' },
    { mode = 'v', 'cm' },
  },

  config = function()
    require 'plugin.comment.cfg'
  end,
}
