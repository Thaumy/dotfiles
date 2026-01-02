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
    vim.opt_local.colorcolumn = '80'
  end,
})
