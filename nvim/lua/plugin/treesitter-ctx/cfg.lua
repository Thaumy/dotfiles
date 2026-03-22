local plugin = require 'treesitter-context'

plugin.setup {
  max_lines = 1,
  multiline_threshold = 1,
}
