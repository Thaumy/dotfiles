local vim = vim

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

vim.diagnostic.config {
  float = {
    border = nil,
  },
}
