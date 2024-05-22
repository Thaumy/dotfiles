local plugin = require 'nvim-treesitter.configs'

local parser_install_dir = '~/.config/nvim-treesitter-parsers'

vim.opt.rtp:append(parser_install_dir)

plugin.setup {
  highlight = {
    enable = true,
  },

  auto_install = false,
  ensure_installed = {},
  parser_install_dir = parser_install_dir,
}
