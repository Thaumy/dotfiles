return {
  'nvim-treesitter/nvim-treesitter-context',
  dev = true,

  config = function()
    require 'plugin.treesitter-ctx.cfg'
  end,
}
