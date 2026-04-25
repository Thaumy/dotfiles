local map = require 'infra.key'.map

map('n', ';', function()
  local wins = vim.api.nvim_list_wins()
  table.sort(wins, function(l, r) return l < r end)

  local curr_win = vim.api.nvim_get_current_win()

  local target_win = nil
  for _, win in ipairs(wins) do
    if win > curr_win then
      local buf = vim.api.nvim_win_get_buf(win)
      local bt = vim.api.nvim_get_option_value('bt', { buf = buf })
      local ft = vim.api.nvim_get_option_value('ft', { buf = buf })
      if
          bt == '' or
          ft == 'neo-tree' or
          ft == 'help' or
          ft == 'buildlog' or
          ft == 'ccapture'
      then
        target_win = win
        break
      end
    end
  end

  if target_win == nil then
    target_win = wins[1]
  end

  if target_win ~= nil then
    vim.api.nvim_set_current_win(target_win)
  end
end)
