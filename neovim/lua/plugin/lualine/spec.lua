return {
  'nvim-lualine/lualine.nvim',
  dev = true,

  event = 'VimEnter',

  config = function()
    require 'plugin.lualine.cfg'
  end,
}
