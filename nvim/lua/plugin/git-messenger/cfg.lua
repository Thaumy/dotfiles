local k = require 'infra.key'

local ns = vim.api.nvim_create_namespace 'git-blame-popup'

k.map('n', 'bl', function()
  vim.cmd 'GitMessenger'
  vim.on_key(function(key, _)
    -- if <Esc> was pressed in normal mode
    if key == '\27' and vim.api.nvim_get_mode().mode == 'n' then
      vim.cmd 'GitMessengerClose'
      vim.on_key(nil, ns)
    end
  end, ns)
end)
