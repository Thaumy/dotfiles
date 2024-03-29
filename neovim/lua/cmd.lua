-- use `Q` to force exit (`qa!`)
vim.api.nvim_create_user_command('Q', 'qa!', {})

-- disable auto comment in normal mode
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { 'o' }
  end,
})
