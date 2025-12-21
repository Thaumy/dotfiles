return {
  'hrsh7th/nvim-cmp',
  dev = true,

  dependencies = {
    require 'plugin.luasnip.spec',
    require 'plugin.colorful-menu.spec',
    { 'hrsh7th/cmp-path',         dev = true },
    { 'hrsh7th/cmp-buffer',       dev = true },
    { 'hrsh7th/cmp-cmdline',      dev = true },
    { 'hrsh7th/cmp-nvim-lsp',     dev = true },
    { 'hrsh7th/cmp-nvim-lua',     dev = true },
    { 'saadparwaiz1/cmp_luasnip', dev = true },
  },

  keys = {
    { mode = 'n', ':' },
    { mode = 'n', '/' },
    { mode = 'n', '?' },
  },
  event = 'InsertEnter',

  config = function()
    require 'plugin.cmp.cfg'
  end,
}
