-- highlight trailing space

local function trailing_spaces_len(line)
  local len = 0
  local i = -1
  while line:sub(i, i) == ' ' do
    i = i - 1
    len = len + 1
  end
  return len
end

local ns = vim.api.nvim_create_namespace 'trailing-space-hl'
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
      local len = line:len()
      if ext_marks[args.buf][index] ~= nil then
        vim.api.nvim_buf_del_extmark(args.buf, ns, ext_marks[args.buf][index])
        ext_marks[args.buf][index] = nil
      end
      if line:sub(-1) == ' ' then
        ext_marks[args.buf][index] = vim.api.nvim_buf_set_extmark(
          args.buf, ns,
          index - 1, len - trailing_spaces_len(line),
          { end_col = len, hl_group = 'TrailingSpace' }
        )
      end
    end
  end)
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'InsertLeave' }, { callback = cb })
