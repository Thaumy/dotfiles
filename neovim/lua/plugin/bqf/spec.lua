return {
  'kevinhwang91/nvim-bqf',
  dev = true,

  event = 'VimEnter',

  config = function()
    require 'plugin.bqf.cfg'
  end,
}
