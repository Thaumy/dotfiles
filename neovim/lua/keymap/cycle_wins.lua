local ui = require 'infra.ui'
local map = require 'infra.key'.map

map('n', ';', function()
  local wins = vim.api.nvim_list_wins()
  local current_win = vim.api.nvim_get_current_win()
  table.sort(wins, function(l, r) return l < r end)
  for _, win in ipairs(wins) do
    if win <= current_win then
      goto continue
    end
    local ft = ui.buf_opt(ui.win_buf(win), 'filetype')
    local not_jump =
        ft == 'qf' or
        ft == 'fidget' or
        ft == ''
    if not not_jump then
      vim.schedule(function()
        vim.api.nvim_set_current_win(win)
      end)
      return
    end
    ::continue::
  end
  if wins[1] ~= nil then
    vim.schedule(function()
      vim.api.nvim_set_current_win(wins[1])
    end)
  end
end)
