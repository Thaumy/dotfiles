local k = require 'infra.key'
local plugin = require 'neo-tree'
local vim_go = vim.go
local vim_api = vim.api
local mappings = require 'plugin.neo-tree.cfg.mappings'
local fs_component_name = require 'neo-tree.sources.filesystem.components'.name
local buf_component_name = require 'neo-tree.sources.buffers.components'.name
local git_component_name = require 'neo-tree.sources.git_status.components'.name

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
      required_width = 40,
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
    width = 36,
    mappings = mappings.window,
  },

  filesystem = {
    components = {
      name = function(config, node, state)
        if node:get_depth() == 1 and node.type ~= 'message' then
          return {
            highlight = 'NeoTreeRootName',
            text = vim.fn.fnamemodify(node.path, ':t'),
          }
        end

        return fs_component_name(config, node, state)
      end,
    },
    follow_current_file = {
      enabled = true,
    },
    hijack_netrw_behavior = 'open_current',
    window = {
      mappings = mappings.filesystem,
    },
    filtered_items = {
      always_show = { '.gitignore' },
    },
  },

  buffers = {
    components = {
      name = function(config, node, state)
        if node:get_depth() == 1 and node.type ~= 'message' then
          return {
            highlight = 'Label',
            text = 'buffers',
          }
        end

        return buf_component_name(config, node, state)
      end,
    },
    window = {
      mappings = mappings.buffers,
    },
  },

  git_status = {
    components = {
      name = function(config, node, state)
        if node:get_depth() == 1 and node.type ~= 'message' then
          return {
            highlight = 'Label',
            text = 'git',
          }
        end

        return git_component_name(config, node, state)
      end,
    },
    window = {
      mappings = mappings.git_status,
    },
  },
}

local neotree_cmd = require 'neo-tree.command'.execute

-- show tree if term width > 120 and
-- nvim not started in diff mode
if
    vim_go.columns > 120 and
    (not vim.tbl_contains(vim.v.argv, '-d'))
then
  neotree_cmd { action = 'show' }
end

-- auto show/close neo-tree when window resized
local debounce = require 'infra.debounce':new()
local auto_toggle = vim_api.nvim_create_autocmd('VimResized', {
  callback = function()
    debounce:schedule(200, function()
      if vim_go.columns < 120 then
        neotree_cmd { action = 'close' }
      else
        neotree_cmd { action = 'show' }
      end
    end)
  end,
})

-- toggle
k.map('n', '<M-e>', function()
  if auto_toggle ~= nil then
    vim_api.nvim_del_autocmd(auto_toggle)
    auto_toggle = nil
  end
  neotree_cmd { action = 'show', toggle = true }
end)
