-- highlight git conflict marks

local function match_bound_mark(line)
  if #line < 8 then
    return false
  end
  local sub = line:sub(1, 8)
  return
      sub == '<<<<<<< ' or
      sub == '>>>>>>> '
end

local ns = vim.api.nvim_create_namespace 'git-conflict-hl'
local hl_results = {}
local debounce = require 'infra.debounce':new()

local cb = function(args)
  local buf = args.buf
  debounce:schedule(200, function()
    if
        (not vim.api.nvim_buf_is_valid(buf)) or
        vim.api.nvim_get_option_value('readonly', { buf = buf }) or
        (not vim.api.nvim_get_option_value('modifiable', { buf = buf })) or
        -- abnormal buffer
        vim.api.nvim_get_option_value('buftype', { buf = buf }) ~= ''
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

    local changedtick = vim.api.nvim_buf_get_changedtick(buf)
    if hl_result.changedtick == changedtick then return end
    hl_result.changedtick = changedtick

    local ext_marks = hl_result.ext_marks

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    for index, line in ipairs(lines) do
      if ext_marks[index] ~= nil then
        vim.api.nvim_buf_del_extmark(buf, ns, ext_marks[index])
        ext_marks[index] = nil
      end
      if match_bound_mark(line) then
        ext_marks[index] = vim.api.nvim_buf_set_extmark(
          buf, ns,
          index - 1, 0,
          { end_col = #line, hl_group = 'GitConflictBoundMark' }
        )
      elseif #line == 7 and line == '=======' then
        ext_marks[index] = vim.api.nvim_buf_set_extmark(
          buf, ns,
          index - 1, 0,
          { end_col = #line, hl_group = 'GitConflictSepMark' }
        )
      end
    end
  end)
end

vim.api.nvim_create_autocmd(
  { 'BufEnter', 'TextChanged', 'InsertLeave' },
  { callback = cb }
)

vim.api.nvim_create_autocmd('BufDelete', {
  callback = function(args)
    hl_results[args.buf] = nil
  end,
})
