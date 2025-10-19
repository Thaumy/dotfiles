local plugin = require 'ibl'

local highlight = {
  'RainbowDelimiterGreen',
  'RainbowDelimiterBlue',
  'RainbowDelimiterCyan',
  'RainbowDelimiterViolet',
  'RainbowDelimiterYellow',
  'RainbowDelimiterOrange',
}

plugin.setup {
  indent  = { char = '▏' },
  scope   = {
    show_start = false,
    show_end = false,
    highlight = highlight,
  },
  exclude = {
    filetypes = {
      'man',
      'help',
      'lspinfo',
      'gitcommit',
      'dashboard',
      'checkhealth',
      '',
    },
    buftypes = {
      'terminal',
      'nofile',
      'quickfix',
      'prompt',
    },
  },
}

local hooks = require 'ibl.hooks'

hooks.register(
  hooks.type.SCOPE_HIGHLIGHT,
  hooks.builtin.scope_highlight_from_extmark
)
