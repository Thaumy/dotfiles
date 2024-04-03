vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  severity_sort = true,
}

-- show diagnostic on hover
vim.o.updatetime = 300
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
local function buf_lsp_client_has(provider)
  local clients = vim.lsp.buf_get_clients()
  if clients == nil or clients[1] == nil then return false end
  local capas = clients[1].server_capabilities
  return capas[provider] == true
end
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    if buf_lsp_client_has('documentHighlightProvider') then
      vim.lsp.buf.document_highlight()
    end
  end
})
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    if buf_lsp_client_has('documentHighlightProvider') then
      vim.lsp.buf.clear_references()
    end
  end
})
