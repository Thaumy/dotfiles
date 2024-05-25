local k = require 'infra.key'
local plugin = require 'telescope'
local path_display = require 'plugin.telescope.cfg.path_display'
local create_layout = require 'plugin.telescope.cfg.create_layout'
local plugin_builtin = require 'telescope.builtin'

plugin.setup {
  defaults = {
    layout_config = {
      size = {
        width = '90%',
        height = '90%',
      },
    },
    create_layout = create_layout,
  },

  pickers = {
    find_files = {
      path_display = path_display,
    },
  },
}

-- go def
k.map('n', '<M-d>', plugin_builtin.lsp_definitions)
-- go ref
k.map('n', '<M-u>', plugin_builtin.lsp_references)
