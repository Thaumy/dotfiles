local vim = vim

require 'keymap'
require 'style'
require 'plugin/mod'
require 'ui'

vim.filetype.add({
  extension = {
    typ = 'typst'
  }
})
