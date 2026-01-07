local k = require 'infra.key'
local plugin = require 'telescope'
local create_layout = require 'plugin.telescope.cfg.create_layout'
local plugin_builtin = require 'telescope.builtin'
local plugin_actions = require 'telescope.actions'

local function send_to_qflist(prompt_bufnr)
  plugin_actions.send_to_qflist(prompt_bufnr)
  if #vim.fn.getqflist() == 0 then return end
  plugin_actions.open_qflist(prompt_bufnr)
end

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
        ['<C-q>'] = send_to_qflist,
        ['<M-q>'] = function() end,
        ['<M-k>'] = plugin_actions.cycle_history_prev,
        ['<M-j>'] = plugin_actions.cycle_history_next,
      },
      n = {
        ['<C-q>'] = send_to_qflist,
        ['<M-q>'] = function() end,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--case-sensitive',
      '--multiline',
    },
  },

  pickers = {
    find_files = {
      path_display = function(_, path)
        local name = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)

        local display = string.format('%s %s', name, parent)
        local hls = {
          { { #name + 1, #display }, 'NonText' },
        }

        return display, hls
      end,
    },
  },
}

-- open
k.map_cmd('n', 'tm', 'Telescope')
-- global search
k.map('n', 'g/', function()
  local ft = vim.bo.ft
  if
      ft == 'neo-tree' or
      ft == 'qf'
  then
    return
  end
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
