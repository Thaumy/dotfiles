local shorten_path = require 'infra.shorten_path'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local grep_previewer = require 'telescope.config'.values.grep_previewer

return function()
  local obj = vim.system({ 'git-conflicts' }, { text = true }):wait()
  if obj.code ~= 0 then
    vim.print(vim.trim(obj.stderr))
    return
  end
  local out = vim.split(obj.stdout, '\n', { trimempty = true });
  if #out == 0 then
    vim.print 'no conflict'
    return
  end

  pickers.new({}, {
    finder = finders.new_table {
      results = out,
      entry_maker = function(line)
        local path, row = string.match(line, '([^:]+):(%d+)')
        local display_path = shorten_path(path)

        local from, to = 0, #display_path
        local hl_path = { { from, to }, 'Directory' }
        from, to = to, to + 1
        local hl_sep1 = { { from, to }, 'Delimiter' };
        from, to = to, to + #row
        local hl_row = { { from, to }, 'Number' };
        local hls = { hl_path, hl_sep1, hl_row }
        local display = string.format('%s:%s', display_path, row)

        return {
          ordinal = display, -- used for filtering
          display = function() return display, hls end,
          filename = path,
          lnum = tonumber(row),
        }
      end,
    },
    previewer = grep_previewer {},
  }):find()
end
