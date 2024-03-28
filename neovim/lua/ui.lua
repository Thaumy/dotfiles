vim.diagnostic.config {
  float = {
    border = nil,
  },
}

-- show diagnostic on hover
vim.o.updatetime = 300
vim.diagnostic.config { virtual_text = false }
local is_cursor_moved = true
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    is_cursor_moved = true
  end
})
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    if (require 'cmp').visible() then return end
    -- only open diagnostic after cursor moved
    if not is_cursor_moved then return end
    is_cursor_moved = false
    vim.diagnostic.open_float()
  end
})

-- hl refs on hover
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    vim.lsp.buf.document_highlight()
  end
})
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    vim.lsp.buf.clear_references()
  end
})
