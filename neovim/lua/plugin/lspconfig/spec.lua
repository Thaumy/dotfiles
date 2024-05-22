return {
  'neovim/nvim-lspconfig',
  dev = true,

  event = 'BufRead',

  config = function()
    require 'plugin.lspconfig.cfg'
  end,
}
