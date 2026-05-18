local vim_fn = vim.fn
local vim_api = vim.api
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark

local function trailing_spaces_len(line)
  local len = 0
  local i = -1
  while line:byte(i) == 32 do -- space char
    i = i - 1
    len = len + 1
  end
  return len
end

local ns = vim_api.nvim_create_namespace 'trailing-space-hl'
local hl_results = {}
vim_api.nvim_create_autocmd('BufDelete', {
  callback = function(args)
    hl_results[args.buf] = nil
  end,
})

local debounce = require 'infra.debounce'
local win_debounce = {}
vim_api.nvim_create_autocmd('WinClosed', {
  callback = function(args)
    win_debounce[tonumber(args.file)] = nil
  end,
})

local function invalid(buf)
  return
      vim_api.nvim_get_option_value('readonly', { buf = buf }) or
      (not vim_api.nvim_get_option_value('modifiable', { buf = buf })) or
      -- abnormal buffer
      vim_api.nvim_get_option_value('buftype', { buf = buf }) ~= ''
end

local when_change = function()
  local win = vim_api.nvim_get_current_win()
  if win_debounce[win] == nil then
    win_debounce[win] = debounce:new()
  end
  win_debounce[win]:schedule(200, function()
    if not vim_api.nvim_win_is_valid(win) then return end

    local buf = vim_api.nvim_win_get_buf(win)
    if invalid(buf) then return end

    if hl_results[buf] == nil then
      hl_results[buf] = {
        changedtick = nil,
        checked_rows = {},
      }
    end
    local hl_result = hl_results[buf]

    local changedtick = vim_api.nvim_buf_get_changedtick(buf)
    if hl_result.changedtick == changedtick then return end
    hl_result.changedtick = changedtick

    -- clear old hl
    vim_api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    hl_result.checked_rows = {}

    local in_insert_mode = vim_api.nvim_get_mode().mode == 'i'
    -- row indexing is one-based
    local cursor_row = vim_api.nvim_win_get_cursor(0)[1]

    local top_row = vim_fn.line('w0', win)
    local bot_row = vim_fn.line('w$', win)
    local lines = vim_api.nvim_buf_get_lines(buf, top_row - 1, bot_row, true)

    for i, line in ipairs(lines) do
      local row = top_row + i - 1

      -- skip the line currently being edited
      if row == cursor_row and in_insert_mode then
        goto continue
      end

      -- has trailing space
      if line:byte(-1) == 32 then
        local len = #line
        nvim_buf_set_extmark(buf, ns,
          row - 1, len - trailing_spaces_len(line),
          { end_col = len, hl_group = 'TrailingSpace' }
        )
      end

      hl_result.checked_rows[row] = true

      ::continue::
    end
  end)
end

vim_api.nvim_create_autocmd(
  { 'BufEnter', 'TextChanged', 'InsertLeave' },
  { callback = when_change }
)

local when_scroll = function()
  local win = vim_api.nvim_get_current_win()
  if win_debounce[win] == nil then
    win_debounce[win] = debounce:new()
  end
  win_debounce[win]:schedule(200, function()
    if not vim_api.nvim_win_is_valid(win) then return end

    local buf = vim_api.nvim_win_get_buf(win)
    if invalid(buf) then return end

    if hl_results[buf] == nil then
      hl_results[buf] = {
        changedtick = vim_api.nvim_buf_get_changedtick(buf),
        checked_rows = {},
      }
    end

    local in_insert_mode = vim_api.nvim_get_mode().mode == 'i'
    -- row indexing is one-based
    local cursor_row = vim_api.nvim_win_get_cursor(0)[1]

    local top_row = vim_fn.line('w0', win)
    local bot_row = vim_fn.line('w$', win)
    local lines = vim_api.nvim_buf_get_lines(buf, top_row - 1, bot_row, true)

    local hl_result = hl_results[buf]

    for i, line in ipairs(lines) do
      local line_len = #line
      if line_len == 0 then goto continue end

      local row = top_row + i - 1

      -- skip checked rows
      if hl_result.checked_rows[row] == true then
        goto continue
      end

      -- skip the line currently being edited
      if row == cursor_row and in_insert_mode then
        goto continue
      end

      -- has trailing space
      if line:byte(-1) == 32 then
        nvim_buf_set_extmark(buf, ns,
          row - 1, line_len - trailing_spaces_len(line),
          { end_col = line_len, hl_group = 'TrailingSpace' }
        )
      end

      hl_result.checked_rows[row] = true

      ::continue::
    end
  end)
end

vim_api.nvim_create_autocmd('WinScrolled', {
  callback = when_scroll,
})
