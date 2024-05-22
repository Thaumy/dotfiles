return {
  'akinsho/bufferline.nvim',
  dev = true,

  event = 'VimEnter',

  config = function()
    require 'plugin.bufline.cfg'
  end,
}
