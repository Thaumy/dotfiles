local types = require 'cmp.types'

local function has_dot_before()
  local pos = vim.api.nvim_win_get_cursor(0)
  local col = pos[2]
  if col == 0 then
    return false
  end
  local line = pos[1]
  return vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col) == '.'
end

return function(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()

  if kind1 == kind2 then
    return
  end

  if has_dot_before() then
    if kind1 == types.lsp.CompletionItemKind.Field then return true end
    if kind2 == types.lsp.CompletionItemKind.Field then return false end

    if kind1 == types.lsp.CompletionItemKind.Property then return true end
    if kind2 == types.lsp.CompletionItemKind.Property then return false end

    if kind1 == types.lsp.CompletionItemKind.Method then return true end
    if kind2 == types.lsp.CompletionItemKind.Method then return false end
  end

  if kind1 == types.lsp.CompletionItemKind.Variable then return true end
  if kind2 == types.lsp.CompletionItemKind.Variable then return false end

  if kind1 == types.lsp.CompletionItemKind.Snippet then return true end
  if kind2 == types.lsp.CompletionItemKind.Snippet then return false end

  return kind1 < kind2
end
