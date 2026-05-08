local map = require 'infra.key'.map
local vim_api = vim.api

-- reduce
map('x', 'h', function()
  if vim_api.nvim_get_mode().mode == 'V' then
    vim.cmd 'normal! <gv'
  else
    vim.cmd 'normal! h'
  end
end)

-- increase
map('x', 'l', function()
  if vim_api.nvim_get_mode().mode == 'V' then
    vim.cmd 'normal! >gv'
  else
    vim.cmd 'normal! l'
  end
end)
