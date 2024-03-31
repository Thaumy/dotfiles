require 'keymap'
require 'style'
require 'cmd'
require 'ui'
require 'plugin/mod'

vim.filetype.add({
  extension = {
    typ = 'typst'
  }
})

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
