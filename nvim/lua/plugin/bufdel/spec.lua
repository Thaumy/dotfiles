return {
  'ojroques/nvim-bufdel',
  dev = true,

  cmd = 'BufDel',

  config = function()
    require 'plugin.bufdel.cfg'
  end,
}
