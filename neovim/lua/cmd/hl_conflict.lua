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
local ext_marks = { {} }
local debounce = require 'infra.debounce':new()

local cb = function(args)
  debounce:schedule(200, function()
    if
        vim.api.nvim_get_option_value('readonly', { buf = args.buf }) or
        (not vim.api.nvim_get_option_value('modifiable', { buf = args.buf })) or
        vim.api.nvim_get_option_value('buftype', { buf = args.buf }) ~= '' -- abnormal buffer
    then
      return
    end

    if ext_marks[args.buf] == nil then
      ext_marks[args.buf] = {}
    end

    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    for index, line in ipairs(lines) do
      if ext_marks[args.buf][index] ~= nil then
        vim.api.nvim_buf_del_extmark(args.buf, ns, ext_marks[args.buf][index])
        ext_marks[args.buf][index] = nil
      end
      if match_bound_mark(line) then
        ext_marks[args.buf][index] = vim.api.nvim_buf_set_extmark(
          args.buf, ns,
          index - 1, 0,
          { end_col = #line, hl_group = 'GitConflictBoundMark' }
        )
      elseif #line == 7 and line == '=======' then
        ext_marks[args.buf][index] = vim.api.nvim_buf_set_extmark(
          args.buf, ns,
          index - 1, 0,
          { end_col = #line, hl_group = 'GitConflictSepMark' }
        )
      end
    end
  end)
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'InsertLeave' }, { callback = cb })
