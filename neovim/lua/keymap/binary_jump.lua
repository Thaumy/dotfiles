local map = require 'infra.key'.map

local ns = vim.api.nvim_create_namespace 'binary-jump-target-hl'

local prev_hl = nil
local function clear_hl()
  if prev_hl ~= nil then
    vim.api.nvim_buf_del_extmark(prev_hl[1], ns, prev_hl[2])
    vim.api.nvim_buf_del_extmark(prev_hl[1], ns, prev_hl[3])
    vim.api.nvim_buf_del_extmark(prev_hl[1], ns, prev_hl[4])
    prev_hl = nil
  end
end

local range = nil

local on_ev = nil
local function hl(row, l, m, r)
  local buf = vim.api.nvim_get_current_buf()
  prev_hl = {
    buf,
    vim.api.nvim_buf_set_extmark(
      buf, ns,
      row - 1, l,
      { end_col = m, hl_group = 'BinaryJumpRange' }
    ),
    vim.api.nvim_buf_set_extmark(
      buf, ns,
      row - 1, m,
      { end_col = m + 1, hl_group = 'BinaryJumpMid' }
    ),
    vim.api.nvim_buf_set_extmark(
      buf, ns,
      row - 1, m + 1,
      { end_col = r + 1, hl_group = 'BinaryJumpRange' }
    ),
  }

  if on_ev == nil then
    on_ev = vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
      once = true,
      callback = function()
        clear_hl()
        range = nil
        on_ev = nil
        vim.on_key(nil, ns)
      end,
    })
    vim.on_key(function(key, _)
      -- if <Esc> was pressed
      if key == '\27' then
        clear_hl()
        range = nil
        if on_ev ~= nil then
          vim.api.nvim_del_autocmd(on_ev)
          on_ev = nil
        end
        vim.on_key(nil, ns)
      end
    end, ns)
  end
end

map({ 'n', 'x' }, '<C-h>', function()
  if #vim.api.nvim_get_current_line() == 0 then return end

  clear_hl()

  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1]
  local col = pos[2]

  local l
  if range == nil then
    l = 0
  else
    l = range[1]
  end
  range = { l, math.max(l, col - 1) }

  if range[1] == range[2] then
    vim.api.nvim_win_set_cursor(0, { row, range[1] })
    range = nil
    return
  end

  local m = math.floor((range[1] + range[2]) / 2)

  if on_ev ~= nil then
    vim.api.nvim_del_autocmd(on_ev)
    on_ev = nil
  end
  vim.api.nvim_win_set_cursor(0, { row, m })

  vim.schedule(function()
    if range ~= nil then
      hl(row, range[1], m, range[2])
    end
  end)
end)

map({ 'n', 'x' }, '<C-l>', function()
  local max = #vim.api.nvim_get_current_line() - 1
  if max == -1 then return end

  clear_hl()

  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1]
  local col = pos[2]

  local r
  if range == nil then
    r = max
  else
    r = math.min(range[2], max)
  end
  range = { math.min(col + 1, r), r }

  if range[1] == range[2] then
    vim.api.nvim_win_set_cursor(0, { row, range[1] })
    range = nil
    clear_hl()
    return
  end

  local m = math.ceil((range[1] + range[2]) / 2)

  if on_ev ~= nil then
    vim.api.nvim_del_autocmd(on_ev)
    on_ev = nil
  end
  vim.api.nvim_win_set_cursor(0, { row, m })

  vim.schedule(function()
    if range ~= nil then
      hl(row, range[1], m, range[2])
    end
  end)
end)
