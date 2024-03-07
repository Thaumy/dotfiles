local vim = vim

require 'keymap'
require 'style'
require 'plugin/mod'
require 'cmd'
require 'ui'

vim.filetype.add({
  extension = {
    typ = 'typst'
  }
})
