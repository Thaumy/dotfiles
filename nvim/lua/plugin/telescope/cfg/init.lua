local k = require 'infra.key'
local shorten_path = require 'infra.shorten_path'
local plugin = require 'telescope'
local create_layout = require 'plugin.telescope.cfg.create_layout'
local plugin_builtin = require 'telescope.builtin'
local plugin_actions = require 'telescope.actions'

local function send_to_qflist(prompt_bufnr)
  plugin_actions.send_to_qflist(prompt_bufnr)
  if #vim.fn.getqflist() == 0 then return end
  plugin_actions.open_qflist(prompt_bufnr)
end

local function make_lsp_picker_entry(opts)
  local path = shorten_path(opts.filename)
  local row = tostring(opts.lnum)
  local col = tostring(opts.col)
  local text = vim.trim(opts.text)

  local from, to = 0, #path
  local hl_path = { { from, to }, 'Directory' }
  from, to = to, to + 1
  local hl_sep1 = { { from, to }, 'Delimiter' };
  from, to = to, to + #row
  local hl_row = { { from, to }, 'Number' };
  from, to = to, to + 1
  local hl_sep2 = { { from, to }, 'Delimiter' }
  from, to = to, to + #col
  local hl_col = { { from, to }, 'Number' }
  local hls = { hl_path, hl_sep1, hl_row, hl_sep2, hl_col }
  local display = string.format('%s:%s:%s %s', path, row, col, text)

  return {
    value = text,      -- will be passed to qf entry text
    ordinal = display, -- used for filtering
    display = function() return display, hls end,
    filename = path,
    lnum = opts.lnum,
    col = opts.col,
  }
end

local severity = vim.diagnostic.severity
local severity_conv = {
  [severity.E] = { 'E', 'ErrorMsg' },
  [severity.W] = { 'W', 'WarningMsg' },
  [severity.I] = { 'I', 'LspDiagnosticsInformation' },
  [severity.N] = { 'H', 'LspDiagnosticsHint' },
}

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
    live_grep = {
      entry_maker = function(line)
        local path, row, col, text = string.match(line, '([^:]+):(%d+):(%d+):%s*(.+)')

        local from, to = 0, #path
        local hl_path = { { from, to }, 'Directory' }
        from, to = to, to + 1
        local hl_sep1 = { { from, to }, 'Delimiter' };
        from, to = to, to + #row
        local hl_row = { { from, to }, 'Number' };
        from, to = to, to + 1
        local hl_sep2 = { { from, to }, 'Delimiter' }
        from, to = to, to + #col
        local hl_col = { { from, to }, 'Number' }
        local hls = { hl_path, hl_sep1, hl_row, hl_sep2, hl_col }
        local display = string.format('%s:%s:%s %s', path, row, col, text)

        return {
          value = text,      -- will be passed to qf entry text
          ordinal = display, -- used for filtering
          display = function() return display, hls end,
          filename = path,
          lnum = tonumber(row),
          col = tonumber(col),
        }
      end,
    },
    lsp_references = {
      entry_maker = make_lsp_picker_entry,
    },
    lsp_implementations = {
      entry_maker = make_lsp_picker_entry,
    },
    diagnostics = {
      entry_maker = function(opts)
        local path = shorten_path(opts.filename)
        local row = tostring(opts.lnum)
        local col = tostring(opts.col)
        local type_mark_and_hl = severity_conv[severity[opts.type]]
        local text = opts.text

        local from, to = 0, #path
        local hl_path = { { from, to }, 'Directory' }
        from, to = to, to + 1
        local hl_sep1 = { { from, to }, 'Delimiter' };
        from, to = to, to + #row
        local hl_row = { { from, to }, 'Number' };
        from, to = to, to + 1
        local hl_sep2 = { { from, to }, 'Delimiter' }
        from, to = to, to + #col
        local hl_col = { { from, to }, 'Number' }
        from, to = to + 1, to + #type_mark_and_hl[1] + 3
        local hl_type = { { from, to }, type_mark_and_hl[2] }
        local hls = { hl_path, hl_sep1, hl_row, hl_sep2, hl_col, hl_type }
        local display = string.format('%s:%s:%s [%s] %s', path, row, col, type_mark_and_hl[1], text)

        return {
          ordinal = display, -- used for filtering
          display = function() return display, hls end,
          filename = path,
          lnum = opts.lnum,
          col = opts.col,
          type = opts.type,
          qf_type = opts.type,
          text = text,
        }
      end,
    },
  },
}

-- open
k.map_cmd('n', 'tm', 'Telescope')
-- global search
k.map('n', 'g/', function()
  if vim.bo.buftype ~= '' then return end
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

-- list git conflicts
local git_conflicts = require 'plugin.telescope.cfg.git_conflicts'
k.map('n', 'cf', git_conflicts)
