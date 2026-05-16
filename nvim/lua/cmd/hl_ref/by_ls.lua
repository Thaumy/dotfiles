local vim_api = vim.api
local vim_lsp = vim.lsp
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark

return function(ns, buf, changedtick, pos_params)
  local clients = vim_lsp.get_clients {
    bufnr = buf,
    method = 'textDocument/documentHighlight',
  }
  if #clients == 0 then return false end

  local function handler(err, hls)
    if err ~= nil or hls == nil then return end

    if
        (not vim_api.nvim_buf_is_valid(buf)) or
        changedtick ~= vim_api.nvim_buf_get_changedtick(buf)
    then
      return
    end

    for _, hl in ipairs(hls) do
      local range = hl.range

      local from = range.start
      local from_row = from.line
      local to = range['end']

      if from_row == to.line then
        nvim_buf_set_extmark(buf, ns,
          from_row, from.character,
          { end_col = to.character, hl_group = 'HlRef' }
        )
      end
    end
  end

  for _, client in ipairs(clients) do
    client:request('textDocument/documentHighlight', pos_params, handler, buf)
  end

  return true
end
