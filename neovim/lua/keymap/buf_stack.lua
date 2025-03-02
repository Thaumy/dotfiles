local map = require 'infra.key'.map

local Stack = require 'infra.stack'
local buf_stack = Stack:new()
local buf_stack_redo = Stack:new()
local navi_by_motion = false

vim.api.nvim_create_autocmd('BufLeave', {
  callback = function(args)
    vim.schedule(function()
      if navi_by_motion then
        navi_by_motion = false
        return
      end

      local info = vim.fn.getbufinfo(args.buf)[1]
      if info == nil or info.listed == 0 then
        return
      end

      local ft = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
      if
          ft == 'neo-tree'
      then
        return
      end

      if buf_stack:top() ~= args.buf then
        buf_stack:push(args.buf)
      end
    end)
  end,
})

map('n', 'bb', function()
  local ft = vim.bo.ft
  if
      ft == 'neo-tree' or
      ft == 'fidget' or
      ft == 'qf'
  then
    return
  end

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
  until buf_stack.len == 0 or buf ~= vim.api.nvim_get_current_buf() and listed
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
  local ft = vim.bo.ft
  if
      ft == 'neo-tree' or
      ft == 'fidget' or
      ft == 'qf'
  then
    return
  end

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
  until buf_stack_redo.len == 0 or buf ~= vim.api.nvim_get_current_buf() and listed
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
