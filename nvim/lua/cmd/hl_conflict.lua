local vim_fn = vim.fn
local vim_api = vim.api
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark

local function match_bound_mark(line)
  if #line < 8 then
    return false
  end
  local sub = line:sub(1, 8)
  return
      sub == '<<<<<<< ' or
      sub == '>>>>>>> '
end

local ns = vim_api.nvim_create_namespace 'git-conflict-hl'
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

local cb = function()
  local win = vim_api.nvim_get_current_win()
  if win_debounce[win] == nil then
    win_debounce[win] = debounce:new()
  end
  win_debounce[win]:schedule(200, function()
    if not vim_api.nvim_win_is_valid(win) then return end

    local buf = vim_api.nvim_win_get_buf(win)
    if
        vim_api.nvim_get_option_value('readonly', { buf = buf }) or
        (not vim_api.nvim_get_option_value('modifiable', { buf = buf })) or
        -- abnormal buffer
        vim_api.nvim_get_option_value('buftype', { buf = buf }) ~= ''
    then
      return
    end

    if hl_results[buf] == nil then
      hl_results[buf] = {
        changedtick = nil,
      }
    end
    local hl_result = hl_results[buf]

    local changedtick = vim_api.nvim_buf_get_changedtick(buf)
    if hl_result.changedtick == changedtick then return end
    hl_result.changedtick = changedtick

    -- clear old hl
    vim_api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    local top_row = vim_fn.line('w0', win)
    local bot_row = vim_fn.line('w$', win)
    local lines = vim_api.nvim_buf_get_lines(buf, top_row - 1, bot_row, true)

    for l_i, line in ipairs(lines) do
      local row = top_row + l_i - 2
      local line_len = #line

      if match_bound_mark(line) then
        nvim_buf_set_extmark(buf, ns,
          row, 0,
          { end_col = line_len, hl_group = 'GitConflictBoundMark' }
        )
      elseif line_len == 7 and line == '=======' then
        nvim_buf_set_extmark(buf, ns,
          row, 0,
          { end_col = 7, hl_group = 'GitConflictSepMark' }
        )
      end
    end
  end)
end

vim_api.nvim_create_autocmd(
  { 'BufEnter', 'TextChanged', 'InsertLeave' },
  { callback = cb }
)
