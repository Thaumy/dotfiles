-- use `Q` to force exit (`q!`)
vim.api.nvim_create_user_command('Q', 'q!', {})

-- disable auto comment in normal mode
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { 'o' }
  end,
})
