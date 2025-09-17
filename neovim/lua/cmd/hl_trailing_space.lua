-- highlight trailing space

local function trailing_spaces_len(line)
  local len = 0
  local i = -1
  while line:byte(i) == 32 do -- space char
    i = i - 1
    len = len + 1
  end
  return len
end

local ns = vim.api.nvim_create_namespace 'trailing-space-hl'
local ext_marks = {}
local checked_rows = {}
local debounce = require 'infra.debounce':new()

local function invalid(buf, win)
  return
      (not vim.api.nvim_buf_is_valid(buf)) or
      (not vim.api.nvim_win_is_valid(win)) or
      vim.api.nvim_get_option_value('readonly', { buf = buf }) or
      (not vim.api.nvim_get_option_value('modifiable', { buf = buf })) or
      -- abnormal buffer
      vim.api.nvim_get_option_value('buftype', { buf = buf }) ~= ''
end

local when_change = function(args)
  local buf = args.buf
  local win = vim.api.nvim_get_current_win()
  debounce:schedule(200, function()
    if invalid(buf, win) then return end

    if ext_marks[buf] == nil then
      ext_marks[buf] = {}
    end
    if checked_rows[buf] == nil then
      checked_rows[buf] = {}
    end

    local in_insert_mode = vim.api.nvim_get_mode().mode == 'i'
    -- row indexing is one-based
    local cursor_row = vim.api.nvim_win_get_cursor(0)[1]

    local win_info = vim.fn.getwininfo(win)[1]
    local row_from = win_info.topline
    local row_to = win_info.botline
    -- indexing is zero-based, end exclusive, so we have [row_from, row_to]
    local lines = vim.api.nvim_buf_get_lines(buf, row_from - 1, row_to, true)

    for i, line in ipairs(lines) do
      local row = row_from + i - 1

      -- clear old hl
      local id = ext_marks[buf][row]
      if id ~= nil then
        vim.api.nvim_buf_del_extmark(buf, ns, id)
        ext_marks[buf][row] = nil
      end

      -- skip the line currently being edited
      if row == cursor_row and in_insert_mode then
        goto continue
      end

      -- has trailing space
      if line:byte(-1) == 32 then
        local len = #line
        ext_marks[buf][row] = vim.api.nvim_buf_set_extmark(
          buf, ns,
          row - 1, len - trailing_spaces_len(line),
          { end_col = len, hl_group = 'TrailingSpace' }
        )
      end

      checked_rows[buf][row] = true

      ::continue::
    end
  end)
end

vim.api.nvim_create_autocmd(
  { 'BufEnter', 'TextChanged', 'InsertLeave' },
  { callback = when_change }
)

local when_scroll = function(args)
  local buf = args.buf
  if buf ~= vim.api.nvim_get_current_buf() then return end
  local win = vim.api.nvim_get_current_win()
  debounce:schedule(200, function()
    if invalid(buf, win) then return end

    if ext_marks[buf] == nil then
      ext_marks[buf] = {}
    end
    if checked_rows[buf] == nil then
      checked_rows[buf] = {}
    end

    local in_insert_mode = vim.api.nvim_get_mode().mode == 'i'
    -- row indexing is one-based
    local cursor_row = vim.api.nvim_win_get_cursor(0)[1]

    local win_info = vim.fn.getwininfo(win)[1]
    local row_from = win_info.topline
    local row_to = win_info.botline
    -- indexing is zero-based, end exclusive, so we have [row_from, row_to]
    local lines = vim.api.nvim_buf_get_lines(buf, row_from - 1, row_to, true)

    for i, line in ipairs(lines) do
      local row = row_from + i - 1

      -- skip checked rows
      if checked_rows[buf][row] ~= nil then
        goto continue
      end

      -- skip the line currently being edited
      if row == cursor_row and in_insert_mode then
        goto continue
      end

      -- has trailing space
      if line:byte(-1) == 32 then
        local len = #line
        ext_marks[buf][row] = vim.api.nvim_buf_set_extmark(
          buf, ns,
          row - 1, len - trailing_spaces_len(line),
          { end_col = len, hl_group = 'TrailingSpace' }
        )
      end

      checked_rows[buf][row] = true

      ::continue::
    end
  end)
end

vim.api.nvim_create_autocmd('WinScrolled', {
  callback = when_scroll,
})

vim.api.nvim_create_autocmd('BufDelete', {
  callback = function(args)
    ext_marks[args.buf] = nil
    checked_rows[args.buf] = nil
  end,
})
