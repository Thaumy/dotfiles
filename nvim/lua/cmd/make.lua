local k = require 'infra.key'

BUILD_JOB_ID = nil
local out = {}
local out_buf = nil
local line_parts = {}

vim.api.nvim_create_user_command('M', function(opts)
  if BUILD_JOB_ID ~= nil then
    if opts.args == ';' then
      vim.fn.jobstop(BUILD_JOB_ID)
      BUILD_JOB_ID = nil
    else
      vim.print 'need to wait or terminate the current build'
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

  if out_buf == nil then
    out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_create_autocmd('BufDelete', {
      buffer = out_buf,
      once = true,
      callback = function() out_buf = nil end,
    })
    vim.api.nvim_set_option_value('ft', 'buildlog', { buf = out_buf })
    vim.api.nvim_set_option_value('mp', mp, { buf = out_buf })
    vim.api.nvim_set_option_value('efm', efm, { buf = out_buf })
  else
    vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, {})
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
      out[#out + 1] = table.concat(line_parts)
      if out_buf ~= nil then
        vim.api.nvim_buf_set_text(out_buf, -1, -1, -1, -1, { out[#out], '' })
      end
      return
    end

    if data[2] ~= nil then
      -- complete the previous line
      if #line_parts ~= 0 then
        out[#out + 1] = table.concat(line_parts)
        if out_buf ~= nil then
          vim.api.nvim_buf_set_text(out_buf, -1, -1, -1, -1, { out[#out], '' })
        end
      end

      -- push lines
      for i = 2, len - 1 do
        if out_buf ~= nil then
          out[#out + 1] = data[i]
          vim.api.nvim_buf_set_text(out_buf, -1, -1, -1, -1, { out[#out], '' })
        end
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
      lines = out,
    })
    out = {}
    vim.api.nvim_exec_autocmds({ 'QuickFixCmdPost' }, {})
    line_parts = {}
    BUILD_JOB_ID = nil
  end

  BUILD_JOB_ID = vim.fn.jobstart(cmd, {
    on_stderr = write_out_buf,
    on_stdout = write_out_buf,
    on_exit = on_exit,
    stdout_buffered = false,
    stderr_buffered = false,
  })
  vim.print '󰞌 building'

  -- silent mode
  if opts.bang then return end

  if curr_buf ~= out_buf then
    vim.api.nvim_win_set_buf(0, out_buf)
  end
end, { nargs = '*', bang = true })

k.map('n', 'M', function()
  vim.api.nvim_feedkeys(':M ', 'n', false)
end)
