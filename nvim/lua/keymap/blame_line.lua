local k = require 'infra.key'
local window = require 'infra.window'

local ns = vim.api.nvim_create_namespace 'git-blame-line'

local blame_win = nil
local blame_buf = nil
local autocmd = nil

local function close_blame()
  if blame_win == nil then return end

  vim.api.nvim_win_close(blame_win, false)
  blame_win = nil
  vim.api.nvim_buf_delete(blame_buf, {})
  blame_buf = nil
end

k.map('n', 'bl', function()
  if vim.bo.bt ~= '' then return end

  if blame_win ~= nil then
    if autocmd ~= nil then
      vim.api.nvim_del_autocmd(autocmd)
      autocmd = nil
    end
    vim.api.nvim_set_current_win(blame_win)
    return
  end

  local path = vim.fs.relpath(vim.loop.cwd(), vim.api.nvim_buf_get_name(0))
  local lineno = vim.api.nvim_win_get_cursor(0)[1]
  local obj = vim.system({ 'git-blame-line', path, lineno }, { text = true }):wait()
  if obj.code ~= 0 then
    vim.print(vim.trim(obj.stderr))
    return
  end
  local lines = vim.split(obj.stdout, '\n', { trimempty = true });

  blame_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(blame_buf, 0, -1, true, lines)
  vim.api.nvim_set_option_value('modifiable', false, { buf = blame_buf })
  vim.api.nvim_create_autocmd({ 'BufLeave' }, {
    once = true,
    buffer = blame_buf,
    callback = close_blame,
  })

  local blame_width = 0
  local max_height = math.floor(vim.o.lines * 0.5) - 3
  for i, line in ipairs(lines) do
    if i > max_height then break end

    if #line >= 72 then
      blame_width = 72
      break
    elseif #line > blame_width then
      blame_width = #line
    end
  end
  local blame_height = math.min(#lines, max_height)

  blame_win = window.open_float(blame_buf, blame_width, blame_height)

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
          close_blame()
        end,
      })
  end

  vim.on_key(function(key, _)
    vim.on_key(nil, ns)
    -- if <Esc> was pressed
    if key == '\27' then close_blame() end
  end, ns)
end)
