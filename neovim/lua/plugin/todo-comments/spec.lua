return {
  'folke/todo-comments.nvim',
  dev = true,

  dependencies = {
    require 'plugin.plenary.spec',
  },

  event = 'BufRead',

  config = function()
    require 'plugin.todo-comments.cfg'
  end,
}
