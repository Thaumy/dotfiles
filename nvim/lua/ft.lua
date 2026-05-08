local vim_fn = vim.fn
local vim_api = vim.api
local vim_filetype = vim.filetype

vim_filetype.add {
  extension = {
    typ = 'typst',
  },
}

vim_filetype.add {
  extension = {
    conf = 'conf',
  },
}

vim_filetype.add {
  extension = {
    v = 'coq',
  },
}

vim_api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim_api.nvim_set_option_value('cc', '72', { scope = 'local' })
    vim.bo.textwidth = 0
  end,
})

vim_api.nvim_create_autocmd('FileType', {
  pattern = 'gitrebase',
  callback = function()
    local lnum = vim_fn.search [[^pick .\+\n\n# Rebase]]
    if lnum == 0 then return end

    local win_height = vim_api.nvim_win_get_height(0)
    local topline = lnum - win_height + 3
    if topline < 2 then return end

    local view = vim_fn.winsaveview()
    view.lnum = lnum
    view.topline = topline
    vim_fn.winrestview(view)
  end,
})
