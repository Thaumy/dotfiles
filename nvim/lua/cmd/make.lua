local k = require 'infra.key'

local job_id = nil
local line_parts = {}

vim.api.nvim_create_user_command('M', function(opts)
  if job_id ~= nil then
    if opts.args == 'kill' then
      vim.fn.jobstop(job_id)
      job_id = nil
    else
      vim.print 'need to wait or kill the last job'
    end
    return
  end

  local curr_buf = vim.api.nvim_get_current_buf()
  local mp = vim.api.nvim_buf_get_option(curr_buf, 'makeprg')
  if mp == '' then
    vim.print 'no makeprg'
    return
  end
  local efm = vim.api.nvim_buf_get_option(curr_buf, 'efm')
  if efm == '' then
    vim.print 'no errorformat'
    return
  end

  local out_buf -- reuse if current buf is buildlog
  if vim.api.nvim_buf_get_option(curr_buf, 'ft') == 'buildlog' then
    out_buf = curr_buf
    vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, {})
  else
    out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_set_option_value('ft', 'buildlog', { buf = out_buf })
    vim.api.nvim_set_option_value('mp', mp, { buf = out_buf })
    vim.api.nvim_set_option_value('efm', efm, { buf = out_buf })
  end
  vim.api.nvim_buf_set_name(out_buf, os.date 'build [%y-%m-%d %H:%M:%S]')

  local args = vim.fn.expandcmd(opts.args)
  local cmd = string.gsub(mp, '%$%*', args)

  local function write_out_buf(_, data, _)
    local len = #data
    local first = data[1]

    if first ~= '' then
      -- part of the previous line
      line_parts[#line_parts + 1] = first
    elseif len == 1 and #line_parts ~= 0 then
      -- data is [''], handle EOF
      vim.api.nvim_buf_set_text(out_buf, -1, -1, -1, -1, { table.concat(line_parts), '' })
      return
    end

    if data[2] ~= nil then
      -- complete the previous line
      if #line_parts ~= 0 then
        vim.api.nvim_buf_set_text(out_buf, -1, -1, -1, -1, { table.concat(line_parts), '' })
      end

      -- push lines
      for i = 2, len - 1 do
        vim.api.nvim_buf_set_text(out_buf, -1, -1, -1, -1, { data[i], '' })
      end

      local last = data[len]
      if last ~= '' then
        line_parts = { last }
      else
        line_parts = {}
      end
    end
  end

  local function on_exit(_, data, _)
    if data ~= 0 then
      vim.print('build exit with ' .. data)
    else
      vim.print 'build complete'
    end
    vim.fn.setqflist({}, ' ', {
      efm = efm,
      lines = vim.api.nvim_buf_get_lines(out_buf, 0, -1, true),
    })
    vim.api.nvim_exec_autocmds({ 'QuickFixCmdPost' }, {})
    line_parts = {}
    job_id = nil
  end

  job_id = vim.fn.jobstart(cmd, {
    on_stderr = write_out_buf,
    on_stdout = write_out_buf,
    on_exit = on_exit,
    stdout_buffered = false,
    stderr_buffered = false,
  })
  vim.print '󰞌 building'

  vim.api.nvim_win_set_buf(0, out_buf)
end, { nargs = '*' })

k.map('n', 'M', function()
  vim.api.nvim_feedkeys(':M ', 'n', false)
end)
