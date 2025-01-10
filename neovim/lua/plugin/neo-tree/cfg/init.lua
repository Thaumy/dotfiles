local k = require 'infra.key'
local ui = require 'infra.ui'
local plugin = require 'neo-tree'
local mappings = require 'plugin.neo-tree.cfg.mappings'
local event_handlers = require 'plugin.neo-tree.cfg.event_handlers'
local Debounce = require 'infra.debounce'

plugin.setup {
  enable_diagnostics = false,

  default_component_configs = {
    indent = {
      indent_marker = '│',
      last_indent_marker = '╰╴',
    },
    modified = {
      symbol = '󰨓',
    },
    icon = {
      folder_closed = '󰉋',
      folder_open = '󰍴',
      folder_empty = '󰉋',
      folder_empty_open = '󰍴',
      default = '∗',
    },
    git_status = {
      symbols = {
        -- Change type
        added     = '',
        deleted   = '',
        modified  = '',
        renamed   = '',
        -- Status type
        untracked = '',
        ignored   = '',
        unstaged  = '',
        staged    = '',
        conflict  = '',
      },
    },
    file_size = {
      required_width = 42,
    },
    type = {
      enabled = false,
    },
    last_modified = {
      required_width = 60,
    },
    symlink_target = {
      enabled = true,
      text_format = ' %s',
    },
  },

  filtered_items = {
    hide_dotfiles = false,
  },

  window = {
    mappings = mappings.window,
  },

  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    hijack_netrw_behavior = 'open_current',
    window = {
      mappings = mappings.filesystem,
    },
  },

  buffers = {
    window = {
      mappings = mappings.buffers,
    },
  },

  git_status = {
    window = {
      mappings = mappings.git_status,
    },
  },

  event_handlers = event_handlers,
}

local show_cmd = 'Neotree action=show'
local close_cmd = 'Neotree action=close'

-- show on plugin loaded if term width > 120
if vim.go.columns > 120 then
  vim.cmd(show_cmd)
end

-- auto show/close neo-tree when window resized
local debounce = Debounce:new()
local auto_toggle = vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    if vim.bo.ft == 'toggleterm' then
      return
    end
    debounce:schedule(200, function()
      if vim.go.columns < 120 then
        vim.cmd(close_cmd)
      elseif vim.go.columns >= 120 then
        vim.cmd(show_cmd)
      end
    end)
  end,
})

-- toggle
k.map('n', 'e', function()
  if auto_toggle ~= nil then
    vim.api.nvim_del_autocmd(auto_toggle)
    auto_toggle = nil
  end
  vim.cmd 'Neotree action=show toggle=true'
end)
