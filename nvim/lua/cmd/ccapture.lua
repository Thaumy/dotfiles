local k = require 'infra.key'

local out_buf = nil

vim.api.nvim_create_user_command('C', function(opts)
  local success, out = pcall(function()
    return vim.api.nvim_exec2(opts.args, { output = true }).output
  end)

  local out_lines = nil
  if success then
    out_lines = vim.split(out, '\n', { trimempty = true });
  else
    out_lines = vim.split(vim.v.errmsg, '\n', { trimempty = true });
  end

  if #out_lines == 0 then
    vim.print 'no output'
    return
  end

  if out_buf == nil then
    out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_create_autocmd('BufDelete', {
      buffer = out_buf,
      once = true,
      callback = function() out_buf = nil end,
    })
    vim.api.nvim_set_option_value('ft', 'ccapture', { buf = out_buf })
    vim.api.nvim_buf_set_name(out_buf, string.format('capture [%s]', opts.args))
  end

  vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, out_lines)

  if vim.api.nvim_get_current_buf() ~= out_buf then
    vim.api.nvim_win_set_buf(0, out_buf)
  end
end, {
  nargs = '*',
  complete = function(arg, full, _)
    local cmd = string.match(full, '^C%s+(.+)')
    if cmd == nil then return {} end

    local type = vim.fn.getcompletiontype(cmd)
    if type == '' then return {} end

    return vim.fn.getcompletion(arg, type)
  end,
})

k.map('n', '<M-;>', function()
  vim.api.nvim_feedkeys(':C ', 'm', false)
end)
