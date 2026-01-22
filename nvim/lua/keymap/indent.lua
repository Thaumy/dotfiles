local map = require 'infra.key'.map

-- reduce
map('x', 'h', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.cmd 'normal! <gv'
  else
    vim.cmd 'normal! h'
  end
end)

-- increase
map('x', 'l', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.cmd 'normal! >gv'
  else
    vim.cmd 'normal! l'
  end
end)
