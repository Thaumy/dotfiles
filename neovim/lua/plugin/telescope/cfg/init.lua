local k = require 'infra.key'
local plugin = require 'telescope'
local path_display = require 'plugin.telescope.cfg.path_display'
local create_layout = require 'plugin.telescope.cfg.create_layout'
local plugin_builtin = require 'telescope.builtin'
local plugin_actions = require 'telescope.actions'

plugin.setup {
  defaults = {
    layout_config = {
      size = {
        width = '90%',
        height = '90%',
      },
    },
    create_layout = create_layout,
    file_ignore_patterns = {
      [[^bin$]],
      [[^obj$]],
      [[^dist$]],
      [[^target$]],
      [[^[^\.]*.lock$]],
      [[^node_modules$]],
      [[^package-lock\.json$]],
    },
    mappings = {
      i = {
        ['<C-q>'] = function(prompt_bufnr)
          plugin_actions.send_to_qflist(prompt_bufnr)
          if #vim.fn.getqflist() == 0 then return end
          plugin_actions.open_qflist(prompt_bufnr)
        end,
        ['<M-k>'] = plugin_actions.cycle_history_prev,
        ['<M-j>'] = plugin_actions.cycle_history_next,
      },
    },
  },

  pickers = {
    find_files = {
      path_display = path_display,
    },
  },
}

-- open
k.map_cmd('n', 'tm', 'Telescope')
-- global search
k.map('n', 'g/', function()
  plugin_builtin.live_grep { debounce = 100 }
end)
-- show diagnostics
k.map('n', 'fd', plugin_builtin.diagnostics)
-- go def
k.map('n', '<M-d>', plugin_builtin.lsp_definitions)
-- go ref
k.map('n', '<M-u>', plugin_builtin.lsp_references)
-- go impl
k.map('n', '<M-i>', plugin_builtin.lsp_implementations)
