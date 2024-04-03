-- neovim infrastructures
require 'plugin/nvim-bufdel'

-- colorizers or signs
require 'plugin/catppucin'
require 'plugin/rainbow-delimiters'
require 'plugin/ibl-nvim'
require 'plugin/colorizer'
require 'plugin/todo-comments'
require 'plugin/gitsigns-nvim'
require 'plugin/nvim-ufo'
require 'plugin/lightspeed-nvim'

-- user interfaces
require 'plugin/lualine'
require 'plugin/neo-tree'
require 'plugin/bufferline'  -- to get neo-tree's hl group, bufferline must be import after it.
require 'plugin/nvim-notify' -- [noice:dep]
require 'plugin/noice'
require 'plugin/toggleterm-nvim'

-- analyzers
require 'plugin/nvim-cmp'
require 'plugin/treesitter'
require 'plugin/nvim-lspconfig'

-- input helpers
require 'plugin/formatter'
require 'plugin/autoclose-nvim'
require 'plugin/nvim-comment'
