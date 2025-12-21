return {
  'norcalli/nvim-colorizer.lua',
  dev = true,

  event = 'BufRead',

  config = function()
    require 'plugin.colorizer.cfg'
  end,
}
