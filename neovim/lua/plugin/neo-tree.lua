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

  window = {
    mappings = {
      ['P']             = '',
      ['l']             = '',
      ['S']             = '',
      ['s']             = '',
      ['t']             = '',
      ['w']             = '',
      ['C']             = '',
      ['z']             = '',
      ['a']             = '',
      ['A']             = '',
      ['d']             = '',
      ['r']             = '',
      ['y']             = '',
      ['x']             = '',
      ['c']             = '',
      ['m']             = '',
      ['q']             = '',
      ['R']             = '',
      ['?']             = '',
      ['<']             = '',
      ['>']             = '',

      ['i']             = 'show_file_details',
      ['p']             = { 'toggle_preview', config = { use_float = false, use_image_nvim = false } },
      ['<Cr>']          = 'open',
      ['<M-j>']         = 'open',
      ['<M-k>']         = 'close_node',
      ['<M-;>']         = 'next_source',
      ['<Esc>']         = 'cancel',
      ['<Tab>']         = 'refresh',
      ['<Space>']       = { 'toggle_node', nowait = false },
      ['<2-LeftMouse>'] = 'open',
    },
  },

  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    hijack_netrw_behavior = 'open_current',
    window = {
      mappings = {
        ['.']     = '',
        ['f']     = '',
        ['H']     = '',
        ['D']     = '',
        ['#']     = '',
        ['[g']    = '',
        [']g']    = '',
        ['o']     = '',
        ['oc']    = '',
        ['od']    = '',
        ['og']    = '',
        ['om']    = '',
        ['on']    = '',
        ['os']    = '',
        ['ot']    = '',
        ['<Bs>']  = '',
        ['<C-x>'] = '',

        ['a']     = { 'add', config = { show_path = 'none' } },
        ['d']     = 'delete',
        ['r']     = 'rename',
        ['/']     = 'fuzzy_finder',
        ['c']     = 'copy',
        ['1']     = 'navigate_up',
        ['2']     = 'set_root',
        ['e']     = 'close_window',
      }
    }
  },

  buffers = {
    window = {
      mappings = {
        ['.']    = '',
        ['o']    = '',
        ['oc']   = '',
        ['od']   = '',
        ['om']   = '',
        ['on']   = '',
        ['os']   = '',
        ['ot']   = '',
        ['bd']   = '',
        ['<Bs>'] = '',

        ['q']    = 'buffer_delete',
        ['/']    = 'fuzzy_finder',
      }
    }
  },

  git_status = {
    window = {
      mappings = {
        ['o']  = '',
        ['A']  = '',
        ['gu'] = '',
        ['ga'] = '',
        ['gr'] = '',
        ['gc'] = '',
        ['gp'] = '',
        ['gg'] = '',
        ['oc'] = '',
        ['od'] = '',
        ['om'] = '',
        ['on'] = '',
        ['os'] = '',
        ['ot'] = '',
      }
    }
  },

  event_handlers = {
    {
      event = 'before_render',
      handler = function()
        if vim.bo.filetype ~= 'neo-tree' then
          return
        end
        -- disable line number
        vim.cmd.setlocal 'nonumber'
        -- fix colorscheme highlight
        vim.cmd.setlocal 'winhighlight=Normal:NeoTreeNormal,NormalNC:NeoTreeNormalNC,SignColumn:NeoTreeSignColumn,CursorLine:NeoTreeCursorLine,FloatBorder:NeoTreeFloatBorder,StatusLine:NeoTreeStatusLine,StatusLineNC:NeoTreeStatusLineNC,VertSplit:NeoTreeVertSplit,EndOfBuffer:NeoTreeEndOfBuffer,WinSeparator:NeoTreeWinSeparator'
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
