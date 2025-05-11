return {
  'catppuccin/nvim',
  dev = true,

  -- HACK: use pkg's `pname` to fix 'colorscheme not found' error,
  -- which is also the dir name in the nvim runtimepath
  name = 'catppuccin-nvim',

  lazy = false,
  priority = 1000,

  config = function()
    require 'plugin.catppuccin.cfg'
  end,
}
