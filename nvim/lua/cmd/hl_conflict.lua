local vim_api = vim.api
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark
local nvim_buf_del_extmark = vim_api.nvim_buf_del_extmark

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
        ext_marks = {},
        changedtick = nil,
      }
    end
    local hl_result = hl_results[buf]

    local changedtick = vim_api.nvim_buf_get_changedtick(buf)
    if hl_result.changedtick == changedtick then return end
    hl_result.changedtick = changedtick

    local ext_marks = hl_result.ext_marks

    local lines = vim_api.nvim_buf_get_lines(buf, 0, -1, false)
    for index, line in ipairs(lines) do
      if ext_marks[index] ~= nil then
        nvim_buf_del_extmark(buf, ns, ext_marks[index])
        ext_marks[index] = nil
      end
      if match_bound_mark(line) then
        ext_marks[index] = nvim_buf_set_extmark(
          buf, ns,
          index - 1, 0,
          { end_col = #line, hl_group = 'GitConflictBoundMark' }
        )
      elseif #line == 7 and line == '=======' then
        ext_marks[index] = nvim_buf_set_extmark(
          buf, ns,
          index - 1, 0,
          { end_col = #line, hl_group = 'GitConflictSepMark' }
        )
      end
    end
  end)
end

vim_api.nvim_create_autocmd(
  { 'BufEnter', 'TextChanged', 'InsertLeave' },
  { callback = cb }
)
