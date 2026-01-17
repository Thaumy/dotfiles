local map = require 'infra.key'.map

local U32Stack = require 'infra.u32_stack'
local buf_stack = U32Stack:new()
local buf_stack_redo = U32Stack:new()
local navi_by_motion = false

vim.api.nvim_create_autocmd('BufLeave', {
  callback = function(args)
    local buf = args.buf
    vim.schedule(function()
      if navi_by_motion then
        navi_by_motion = false
        return
      end

      if (not vim.api.nvim_buf_is_valid(buf)) or
          (not vim.api.nvim_get_option_value('buflisted', { buf = buf }))
      then
        return
      end

      if vim.api.nvim_get_option_value('buftype', { buf = buf }) ~= '' then
        return
      end

      if buf_stack:top() ~= buf then
        buf_stack:push(buf)
      end
    end)
  end,
})

map('n', 'bb', function()
  if vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= '' then
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
      if vim.api.nvim_buf_is_valid(buf) and
          vim.api.nvim_get_option_value('buflisted', { buf = buf })
      then
        listed = true
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
  if vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= '' then
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
      if vim.api.nvim_buf_is_valid(buf) and
          vim.api.nvim_get_option_value('buflisted', { buf = buf })
      then
        listed = true
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
