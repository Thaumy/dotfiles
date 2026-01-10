local map = require 'infra.key'.map

-- reduce
map('x', 'h', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.api.nvim_feedkeys('<gv', 'n', false)
  else
    local pos = vim.api.nvim_win_get_cursor(0)
    if pos[2] > 1 then
      pos[2] = pos[2] - 1
      vim.api.nvim_win_set_cursor(0, pos)
    end
  end
end)

-- increase
map('x', 'l', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.api.nvim_feedkeys('>gv', 'n', false)
  else
    local pos = vim.api.nvim_win_get_cursor(0)
    pos[2] = pos[2] + 1
    vim.api.nvim_win_set_cursor(0, pos)
  end
end)
