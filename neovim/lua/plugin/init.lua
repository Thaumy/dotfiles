local plugin = require 'lazy'

local specs = {
  -- infrastructures
  require 'plugin.bufdel.spec',

  -- colorizers or signs
  require 'plugin.ufo.spec',
  require 'plugin.gitsigns.spec',
  require 'plugin.colorizer.spec',
  require 'plugin.catppuccin.spec',
  require 'plugin.illuminate.spec',
  require 'plugin.todo-comments.spec',

  -- user interfaces
  require 'plugin.bqf.spec',
  require 'plugin.fidget.spec',
  require 'plugin.lualine.spec',
  require 'plugin.neo-tree.spec',
  require 'plugin.telescope.spec',
  require 'plugin.md-preview.spec',
  require 'plugin.git-messenger.spec',
  require 'plugin.actions-preview.spec',

  -- analyzers
  require 'plugin.ionide.spec',
  require 'plugin.lspconfig.spec',
  require 'plugin.treesitter.spec',

  -- input helpers
  require 'plugin.cmp.spec',
  require 'plugin.crates.spec',
  require 'plugin.comment.spec',
  require 'plugin.neoformat.spec',
  require 'plugin.autoclose.spec',
}

local cfg = {
  default = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tutor',
        'tohtml',
        'matchit',
        'rplugin',
        'spellfile',
        'tarPlugin',
        'zipPlugin',
        'netrwPlugin',
      },
    },
  },
  dev = { path = '~/.config/nvim-plugins' },
  rocks = { enabled = false },
  install = { missing = false },
  change_detection = { enabled = false },
}

-- use <Esc> to close lazy menu
require 'lazy.view.config'.keys.close = '<Esc>'

plugin.setup(specs, cfg)
