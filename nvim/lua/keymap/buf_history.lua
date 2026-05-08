local lib = LIBNVIMCFG
local map = require 'infra.key'.map
local vim_api = vim.api

BUF_HISTORY = {}

vim_api.nvim_create_autocmd('WinEnter', {
  callback = function(args)
    local bt = vim_api.nvim_get_option_value('buftype', { buf = args.buf })
    if bt ~= '' then return end

    local win = vim_api.nvim_get_current_win()
    if BUF_HISTORY[win] == nil then
      BUF_HISTORY[win] = lib.buf_history_new()
    end
  end,
})

vim_api.nvim_create_autocmd('WinClosed', {
  callback = function(args)
    local win = tonumber(args.match)
    if win == nil then return end
    local bh = BUF_HISTORY[win]
    if bh == nil then return end
    BUF_HISTORY[win] = nil
    lib.buf_history_drop(bh)
  end,
})

NAVI_BY_MOTION = false

vim_api.nvim_create_autocmd('BufEnter', {
  callback = function(args)
    if NAVI_BY_MOTION then
      NAVI_BY_MOTION = false
      return
    end

    local win = vim_api.nvim_get_current_win()

    local bh = BUF_HISTORY[win]
    if bh == nil then return end

    if lib.buf_history_cursor(bh) == 0 and
        vim_api.nvim_buf_get_name(args.buf) == ''
    then
      return
    end

    lib.buf_history_add(bh, args.buf)
  end,
})

map('n', 'bb', function()
  local win = vim_api.nvim_get_current_win()

  local bh = BUF_HISTORY[win]
  if bh == nil then return end

  local buf
  while true do
    buf = lib.buf_history_undo(bh)
    if buf == 0 then
      vim.notify 'reached oldest'
      return
    end

    if vim_api.nvim_buf_is_valid(buf) then
      break
    else
      lib.buf_history_invalid(bh, buf)
    end
  end

  NAVI_BY_MOTION = true
  vim_api.nvim_set_current_buf(buf)
end)

map('n', 'B', function()
  local win = vim_api.nvim_get_current_win()

  local bh = BUF_HISTORY[win]
  if bh == nil then return end

  local buf
  while true do
    buf = lib.buf_history_redo(bh)
    if buf == 0 then
      vim.notify 'reached latest'
      return
    end

    if vim_api.nvim_buf_is_valid(buf) then
      break
    else
      lib.buf_history_invalid(bh, buf)
    end
  end

  NAVI_BY_MOTION = true
  vim_api.nvim_set_current_buf(buf)
end)
