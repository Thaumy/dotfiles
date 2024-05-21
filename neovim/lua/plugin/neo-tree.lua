local ui = require 'infra.ui'
local k = require 'infra.keymap'
local plugin = require 'neo-tree'

vim.go.fillchars = 'vert:▎,vertleft:▎,vertright:▎,verthoriz:─,horiz:─,horizup:─,horizdown:─'

vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#83c66d' })
vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', { fg = '#ff8700' })

plugin.setup {
  enable_diagnostics = false,

  default_component_configs = {
    indent = {
      indent_marker = '🭲',
      last_indent_marker = '🮡',
    },
    modified = {
      symbol = '● '
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
        added     = '+',
        deleted   = '-',
        modified  = '~',
        renamed   = '↗',
        -- Status type
        untracked = '',
        ignored   = '',
        unstaged  = '',
        staged    = '',
        conflict  = '!',
      },
    },
    file_size = {
      required_width = 50,
    },
    type = {
      enabled = false,
    },
    last_modified = {
      required_width = 70,
    },
    symlink_target = {
      enabled = true,
      text_format = ' %s',
    },
  },

  filtered_items = {
    hide_dotfiles = false,
  },

  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    hijack_netrw_behavior = 'open_current',
  },

  window = {
    mappings = {
      ['m'] = '',
      ['f'] = '',
      ['o'] = '',
      ['t'] = '',
      ['<'] = '',
      ['>'] = '',
      ['h'] = 'prev_source',
      ['l'] = 'next_source',
      ['s'] = 'fuzzy_finder',
      ['<Bs>'] = '',
      ['<M-j>'] = 'open',
      ['<M-k>'] = 'close_node',
      ['<Esc>'] = 'navigate_up',
      ['<Space>'] = { 'toggle_preview', config = { use_float = false } },
    }
  },

  event_handlers = {
    -- disable line number
    {
      event = 'before_render',
      handler = function()
        if vim.bo.filetype == 'neo-tree' then
          vim.cmd 'setlocal nonumber'
        end
      end,
    },
  }
}

local show_cmd = 'Neotree action=show toggle=true'
local close_cmd = 'Neotree action=close toggle=true'

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local term_width = vim.go.columns
    if term_width > 120 then
      vim.cmd(show_cmd)
    end
  end
})

local auto_toggle = true

-- auto show/close neo-tree when window resized
local function is_neotree_visible()
  return ui.any_buf_ft('neo-tree')
end
local function neotree_show()
  if not is_neotree_visible() then
    vim.cmd(show_cmd)
  end
end
local function neotree_close()
  if is_neotree_visible() then
    vim.cmd(close_cmd)
  end
end
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    if not auto_toggle then
      return
    end
    local term_width = vim.go.columns
    if term_width > 120 then
      neotree_show()
    else
      neotree_close()
    end
  end
})

-- toggle
k.map('n', 'e', function()
  auto_toggle = false
  vim.cmd(show_cmd)
end)
