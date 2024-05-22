return {
  'catppuccin/nvim',
  dev = true,

  lazy = false,
  priority = 1000,
  -- HACK: use pkg's `pname` to fix 'colorscheme not found' error,
  -- which is also the dir name in the nvim runtimepath
  name = 'catppuccin-nvim',

  config = function()
    require 'plugin.catppuccin.cfg'
  end,
}
