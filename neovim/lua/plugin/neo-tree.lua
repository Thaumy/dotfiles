local plugin = require 'neo-tree'

vim.o.fillchars = 'vert:▎,horiz:─'

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
      folder_closed = '🖿',
      folder_open = '-',
      folder_empty = '🖿',
      folder_empty_open = '-',
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
    },
  },

  filtered_items = {
    hide_dotfiles = false,
  },

  filesystem = {
    follow_current_file = {
      enabled = true,
    },
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

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local term_width = vim.go.columns
    if term_width > 120 then
      vim.cmd 'Neotree show'
    end
  end
})

-- auto show/close neo-tree when window resized
local function is_neotree_visible()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if ft == 'neo-tree' then
      return true
    end
  end
  return false
end
local function neotree_show()
  if not is_neotree_visible() then
    vim.cmd 'Neotree show'
  end
end
local function neotree_close()
  if is_neotree_visible() then
    vim.cmd 'Neotree close'
  end
end
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    local term_width = vim.go.columns
    if term_width > 120 then
      neotree_show()
    else
      neotree_close()
    end
  end
})
