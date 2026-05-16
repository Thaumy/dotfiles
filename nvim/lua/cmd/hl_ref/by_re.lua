local lib = LIBNVIMCFG
local ffi = require 'ffi'
local vim_fn = vim.fn
local vim_api = vim.api
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark

local pre_alloc = lib.match_words_pre_alloc()

return function(ns, buf, win, cursor_row, cursor_col, top_row, bot_row)
  local cursor_line = vim_api.nvim_buf_get_lines(buf, cursor_row, cursor_row + 1, true)[1]
  local cursor_line_len = #cursor_line
  if cursor_line_len == 0 then return end

  local sel_from_ptr = ffi.new 'size_t[1]'
  local sel_to_ptr = ffi.new 'size_t[1]'

  local found = lib.select_word(
    ffi.cast('uint8_t*', cursor_line),
    ffi.new('size_t', cursor_line_len),
    ffi.new('size_t', cursor_col),
    sel_from_ptr,
    sel_to_ptr
  )
  if not found then return end

  local sel_from = tonumber(sel_from_ptr[0])
  local sel_to = tonumber(sel_to_ptr[0])
  local word = string.sub(cursor_line, sel_from + 1, sel_to)
  local word_len = #word

  local view_lines = vim_api.nvim_buf_get_lines(buf, top_row, bot_row + 1, true)
  local view_lines_len = #view_lines
  local have_fold = view_lines_len > vim_api.nvim_win_get_height(win)

  local l_i = 0
  while l_i < view_lines_len do
    local row = top_row + l_i
    l_i = l_i + 1

    if have_fold then
      local fold_end = vim_fn.foldclosedend(row)
      if fold_end ~= -1 then
        l_i = fold_end - top_row + 1
        goto continue
      end
    end

    local line = view_lines[l_i]
    local line_len = #line

    -- skip large line for performance
    if line_len < word_len or line_len > 200 then goto continue end

    local matches_ptr = ffi.new 'size_t[1]'
    local matches_len = tonumber(lib.match_words(
      pre_alloc,
      ffi.cast('uint8_t*', line),
      ffi.new('size_t', line_len),
      ffi.cast('uint8_t*', word),
      ffi.new('size_t', word_len),
      matches_ptr
    ))
    if matches_len == 0 then goto continue end
    local matches = ffi.cast('size_t*', matches_ptr[0])

    for m_i = 0, matches_len - 1, 2 do
      local match_l = tonumber(matches[m_i])
      local match_r = tonumber(matches[m_i + 1])
      nvim_buf_set_extmark(buf, ns,
        row, match_l,
        { end_col = match_r, hl_group = 'HlRef' }
      )
    end

    ::continue::
  end
end
