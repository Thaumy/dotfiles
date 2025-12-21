return {
  'nvim-lualine/lualine.nvim',
  dev = true,

  lazy = false,

  config = function()
    require 'plugin.lualine.cfg'
  end,
}
