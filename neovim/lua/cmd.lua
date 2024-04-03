-- use `Q` to force exit (`qa!`)
vim.api.nvim_create_user_command('Q', 'qa!', {})

-- disable auto comment in normal mode
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { 'o' }
  end,
})

-- show trailing whitespace
vim.cmd('highlight TrailingWhitespace guibg=#ffdd00')
vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    local no_hl =
        ft == '' or
        ft == 'neo-tree' or
        ft == 'lspinfo'
    if no_hl then
      vim.cmd('match TrailingWhitespace //')
    else
      vim.cmd('match TrailingWhitespace /\\s\\+$/')
    end
  end,
})
vim.api.nvim_create_autocmd({ 'TermEnter', 'InsertEnter' }, {
  callback = function()
    vim.cmd('match TrailingWhitespace //')
  end,
})
