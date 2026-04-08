vim.loader.enable()

VVP_MODE = os.getenv 'NVIM_VVP' ~= nil

require 'lib'
require 'ft'
require 'opt'
require 'lsp'
require 'cmd'
require 'keymap'
require 'plugin'
