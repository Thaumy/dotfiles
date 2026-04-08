return {
  'nvim-lualine/lualine.nvim',
  dev = true,

  enabled = not VVP_MODE,

  lazy = false,

  config = function()
    require 'plugin.lualine.cfg'
  end,
}
