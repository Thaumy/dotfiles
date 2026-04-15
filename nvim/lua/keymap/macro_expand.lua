local k = require 'infra.key'
local window = require 'infra.window'

local ns = vim.api.nvim_create_namespace 'macro-expand'

local expand_win = nil
local expand_buf = nil
local autocmd = nil

local function close_expand()
  if expand_win == nil then return end

  vim.api.nvim_win_close(expand_win, false)
  expand_win = nil
  vim.api.nvim_buf_delete(expand_buf, {})
  expand_buf = nil
end

k.map('n', '<M-z>', function()
  if expand_win ~= nil then
    if autocmd ~= nil then
      vim.api.nvim_del_autocmd(autocmd)
      autocmd = nil
    end
    vim.api.nvim_set_current_win(expand_win)
    return
  end

  -- now we only have impl for Rust
  local client = (vim.lsp.get_clients {
    name = 'rust_analyzer',
    bufnr = vim.api.nvim_get_current_buf(),
  })[1]
  if client == nil then return end

  local params = vim.lsp.util.make_position_params(0, 'utf-8')
  local ret = client:request_sync('rust-analyzer/expandMacro', params)

  local lines = {}
  if ret ~= nil and ret.err == nil and ret.result ~= nil then
    vim.list_extend(lines, vim.split(ret.result.expansion, '\n', { trimempty = true }))
  else
    return
  end

  expand_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(expand_buf, 0, -1, true, lines)
  vim.api.nvim_set_option_value('modifiable', false, { buf = expand_buf })
  vim.api.nvim_set_option_value('filetype', 'rust', { buf = expand_buf })
  vim.api.nvim_create_autocmd({ 'BufLeave' }, {
    once = true,
    buffer = expand_buf,
    callback = close_expand,
  })

  local expand_width = 0
  local max_height = math.floor(vim.o.lines * 0.5) - 3
  for i, line in ipairs(lines) do
    if i > max_height then break end

    if #line >= 100 then
      expand_width = 100
      break
    elseif #line > expand_width then
      expand_width = #line
    end
  end
  local expand_height = math.min(#lines, max_height)

  expand_win = window.open_float(expand_buf, expand_width, expand_height)

  if autocmd == nil then
    autocmd = vim.api.nvim_create_autocmd(
      { 'CursorMoved', 'BufLeave', 'ModeChanged', 'WinScrolled' },
      {
        once = true,
        buffer = vim.api.nvim_get_current_buf(),
        callback = function()
          vim.api.nvim_del_autocmd(autocmd)
          autocmd = nil
          vim.on_key(nil, ns)
          close_expand()
        end,
      })
  end

  vim.on_key(function(key, _)
    vim.on_key(nil, ns)
    -- if <Esc> was pressed
    if key == '\27' then close_expand() end
  end, ns)
end)
