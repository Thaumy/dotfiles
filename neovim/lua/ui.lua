local api = vim.api

function string.starts(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

-- open nvim-tree when read file
-- TODO: nvim-tree not open on BufEnter
api.nvim_create_autocmd({ "BufReadPost" }, {
  callback = function()
    -- HACK: for some nvim-tree reasons, only this way will be work
    vim.fn.timer_start(0, function()
      require "nvim-tree.api".tree.open()
      vim.cmd("wincmd l")
    end)
  end,
})

-- exit vim when all buffers is hidden
api.nvim_create_autocmd({ "WinEnter" }, {
  callback = function()
    if vim.fn.winnr('$') == 1 and string.starts(vim.fn.bufname(), "NvimTree_") then
      vim.cmd "q"
    end
  end
  ,
})

-- close nvim-tree when buffer has no name. e.g. open dashboard.
api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    if vim.fn.winnr('$') == 2 and vim.fn.bufname() == "" then
      require "nvim-tree.api".tree.close()
    end
  end
})
