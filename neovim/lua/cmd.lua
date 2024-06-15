local ui = require 'infra.ui'

-- disable auto comment in normal mode
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'o' }
  end,
})

-- show trailing whitespace
vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
  callback = function()
    if
        vim.bo.bt ~= '' or
        vim.bo.readonly or
        (not vim.bo.modifiable)
    then
      vim.cmd 'match TrailingWhitespace //'
    else
      vim.cmd 'match TrailingWhitespace /\\s\\+$/'
    end
  end,
})
vim.api.nvim_create_autocmd({ 'TermEnter', 'InsertEnter' }, {
  callback = function()
    vim.cmd 'match TrailingWhitespace //'
  end,
})

-- auto switch fcitx
local fcitx_state = nil
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if fcitx_state == '2\n' then
      os.execute 'fcitx5-remote -o'
    end
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    local handle = io.popen 'fcitx5-remote'
    if handle == nil then return end
    fcitx_state = handle:read 'a'
    handle:close()
    os.execute 'fcitx5-remote -c'
  end,
})
