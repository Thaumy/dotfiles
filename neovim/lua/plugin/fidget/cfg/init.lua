local k                          = require 'infra.key'
local fn                         = require 'plugin.fidget.cfg.fn'
local plugin                     = require 'fidget'
local notification               = require 'fidget.notification'

notification.default_config.icon = '󰍧 '

plugin.setup {
  progress = {
    display = {
      render_limit = 16, -- How many LSP messages to show at once
      done_ttl = 0, -- How long a message should persist after completion
      done_icon = '󰄬 ', -- Icon shown when all LSP progress tasks are complete
      progress_icon = fn.blink_icon,
      format_message = fn.lsp_progress_message_fmt,
    },
  },

  notification = {
    poll_rate = 20,
    override_vim_notify = true,
    configs = { default = notification.default_config },
    view = { group_separator = '' },
    window = {
      normal_hl = 'Normal',
      winblend = 10,
      border = 'none',
      zindex = 45,
      max_width = 0,
      max_height = 0,
      x_padding = 0,
      y_padding = 0,
    },
  },

  integration = {
    ['nvim-tree'] = { enable = false },
    ['xcodebuild-nvim'] = { enable = true },
  },
}

k.map('n', 'fc', notification.clear)
