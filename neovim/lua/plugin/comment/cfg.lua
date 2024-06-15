local plugin = require 'Comment'

plugin.setup {
  padding = false,
  toggler = {
    line = 'm',
    block = 'bm',
  },
  opleader = {
    line = 'm',
    block = 'bm',
  },
  mappings = {
    basic = true,
    extra = false,
  },
}
