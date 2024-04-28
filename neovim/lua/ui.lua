local map_opts = { noremap = true, silent = true }

local function unmap(modes, lhs)
  vim.keymap.set(modes, lhs, '<nop>', map_opts)
end

local function map(modes, lhs, rhs)
  vim.keymap.set(modes, lhs, rhs, map_opts)
  if type(rhs) == 'string' then
    unmap(modes, rhs) -- unmap original
  end
end

vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  severity_sort = true,
}

-- show diagnostic on hover
vim.o.updatetime = 300
local is_cursor_moved = true
local diagnostic_buf = nil
local is_hover_on = false
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    is_cursor_moved = true
    is_hover_on = false
  end
})
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    if is_hover_on then return end
    -- only open diagnostic after cursor moved
    if not is_cursor_moved then return end
    if (require 'cmp').visible() then return end
    is_cursor_moved = false
    diagnostic_buf, _ = vim.diagnostic.open_float({ scope = 'cursor' })
  end
})

-- show def
map('n', '<M-a>', function()
  is_hover_on = true
  vim.lsp.buf.hover()
  -- close diagnostic buf when show def
  if diagnostic_buf ~= nil and vim.api.nvim_buf_is_valid(diagnostic_buf) then
    vim.api.nvim_buf_delete(diagnostic_buf, {})
    diagnostic_buf = nil
  end
end)

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
