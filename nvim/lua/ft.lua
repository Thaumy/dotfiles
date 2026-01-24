vim.filetype.add {
  extension = {
    typ = 'typst',
  },
}

vim.filetype.add {
  extension = {
    conf = 'conf',
  },
}

vim.filetype.add {
  extension = {
    v = 'coq',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.api.nvim_set_option_value('cc', '72', { scope = 'local' })
    vim.bo.textwidth = 0
  end,
})
