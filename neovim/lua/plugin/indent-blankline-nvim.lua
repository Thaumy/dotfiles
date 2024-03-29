local plugin = require 'ibl'

local highlight = {
  'RainbowDelimiterRed',
  'RainbowDelimiterYellow',
  'RainbowDelimiterBlue',
  'RainbowDelimiterOrange',
  'RainbowDelimiterGreen',
  'RainbowDelimiterViolet',
  'RainbowDelimiterCyan',
}
vim.g.rainbow_delimiters = { highlight = highlight }

plugin.setup {
  indent = { char = '▏' },
  scope = {
    show_start = false,
    highlight = highlight
  }
}

local hooks = require "ibl.hooks"
hooks.register(
  hooks.type.SCOPE_HIGHLIGHT,
  hooks.builtin.scope_highlight_from_extmark
)
