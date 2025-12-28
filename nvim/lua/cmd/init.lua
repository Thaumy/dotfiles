require 'cmd.make'
require 'cmd.im_switch'
require 'cmd.hl_conflict'
require 'cmd.hl_trailing_space'

-- disable auto comment in normal mode
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'o' }
  end,
})
