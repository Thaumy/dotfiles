local Debounce = require 'infra.debounce'

-- disable auto comment in normal mode
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'o' }
  end,
})

-- highlight trailing space
do
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
  local debounce = Debounce:new()

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
end

-- auto switch fcitx
local fcitx_state = nil
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if fcitx_state == '2\n' then
      os.execute 'fcitx5-remote -o'
    end
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    local handle = io.popen 'fcitx5-remote'
    if handle == nil then return end
    fcitx_state = handle:read 'a'
    handle:close()
    os.execute 'fcitx5-remote -c'
  end,
})

-- highlight git conflict marks
do
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

  vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'InsertLeave' }, {
    callback = function(args)
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
    end,
  })
end
