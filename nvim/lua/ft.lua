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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitrebase',
  callback = function()
    local lnum = vim.fn.search [[^pick .\+\n\n# Rebase]]
    if lnum == 0 then return end

    local win_height = vim.api.nvim_win_get_height(0)
    local topline = lnum - win_height + 3
    if topline < 2 then return end

    local view = vim.fn.winsaveview()
    view.lnum = lnum
    view.topline = topline
    vim.fn.winrestview(view)
  end,
})
