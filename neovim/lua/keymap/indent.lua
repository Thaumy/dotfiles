local map = require 'infra.key'.map

-- reduce
map('v', 'h', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.api.nvim_feedkeys('<gv', 'n', false)
  else
    vim.api.nvim_feedkeys('h', 'n', false)
  end
end)

-- increase
map('v', 'l', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.api.nvim_feedkeys('>gv', 'n', false)
  else
    vim.api.nvim_feedkeys('l', 'n', false)
  end
end)