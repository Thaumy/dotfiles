local plugin = require 'Comment'

plugin.setup {
  padding = false,
  toggler = {
    line = 'm',
    block = 'cm',
  },
  opleader = {
    line = 'm',
    block = 'cm',
  },
  mappings = {
    basic = true,
    extra = false,
  },
}
