local map = require 'infra.key'.map

local U32Stack = require 'infra.u32_stack'
local buf_stack = U32Stack:new()
local buf_stack_redo = U32Stack:new()
local navi_by_motion = false

local function ignore_ft(ft)
  return
      ft == 'neo-tree' or
      ft == 'qf' or
      ft == 'fidget'
end

vim.api.nvim_create_autocmd('BufLeave', {
  callback = function(args)
    local buf = args.buf
    vim.schedule(function()
      if navi_by_motion then
        navi_by_motion = false
        return
      end

      local info = vim.fn.getbufinfo(buf)[1]
      if info == nil or info.listed == 0 then
        return
      end

      local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
      if ignore_ft(ft) then return end

      if buf_stack:top() ~= buf then
        buf_stack:push(buf)
      end
    end)
  end,
})

map('n', 'bb', function()
  if ignore_ft(vim.bo.ft) then return end

  -- buf is curr
  local buf = vim.api.nvim_get_current_buf()
  if buf_stack_redo:top() ~= buf then
    buf_stack_redo:push(buf)
  end

  local listed = false
  repeat
    -- buf is prev
    buf = buf_stack:pop()
    if buf ~= nil then
      local info = vim.fn.getbufinfo(buf)[1]
      if info ~= nil then
        listed = info.listed == 1
      end
    end
  until buf_stack:len() == 0 or buf ~= vim.api.nvim_get_current_buf() and listed
  if
      buf == nil or
      (not listed) or
      (not vim.api.nvim_buf_is_valid(buf))
  then
    return
  end

  navi_by_motion = true
  vim.api.nvim_set_current_buf(buf)
end)

map('n', 'B', function()
  if ignore_ft(vim.bo.ft) then return end

  -- buf is curr
  local buf = vim.api.nvim_get_current_buf()
  if buf_stack:top() ~= buf then
    buf_stack:push(buf)
  end

  local listed = false
  repeat
    -- buf is next
    buf = buf_stack_redo:pop()
    if buf ~= nil then
      local info = vim.fn.getbufinfo(buf)[1]
      if info ~= nil then
        listed = info.listed == 1
      end
    end
  until buf_stack_redo:len() == 0 or buf ~= vim.api.nvim_get_current_buf() and listed
  if
      buf == nil or
      (not listed) or
      (not vim.api.nvim_buf_is_valid(buf))
  then
    return
  end

  navi_by_motion = true
  vim.api.nvim_set_current_buf(buf)
end)
