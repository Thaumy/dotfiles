return {
  'aznhe21/actions-preview.nvim',
  dev = true,

  keys = {
    { mode = 'n', '<M-q>' },
  },

  config = function()
    require 'plugin.actions-preview.cfg'
  end,
}
