local k = require 'infra.key'
local vim_fn = vim.fn
local vim_api = vim.api
local table_concat = table.concat
local nvim_buf_set_text = vim_api.nvim_buf_set_text

BUILD_JOB_ID = nil
local out = {}
local out_buf = nil
local line_parts = {}

vim_api.nvim_create_user_command('M', function(opts)
  if BUILD_JOB_ID ~= nil then
    if opts.args == ';' then
      vim_fn.jobstop(BUILD_JOB_ID)
      BUILD_JOB_ID = nil
    else
      vim.print 'need to wait or terminate the current build'
    end
    return
  end

  local curr_buf = vim_api.nvim_get_current_buf()
  local mp = vim_api.nvim_get_option_value('makeprg', { buf = curr_buf })
  if mp == '' then
    vim.print 'no makeprg'
    return
  end
  local efm = vim_api.nvim_get_option_value('efm', { buf = curr_buf })
  if efm == '' then
    vim.print 'no errorformat'
    return
  end

  if out_buf == nil then
    out_buf = vim_api.nvim_create_buf(true, true)
    vim_api.nvim_create_autocmd('BufDelete', {
      buffer = out_buf,
      once = true,
      callback = function() out_buf = nil end,
    })
    vim_api.nvim_set_option_value('ft', 'buildlog', { buf = out_buf })
    vim_api.nvim_set_option_value('mp', mp, { buf = out_buf })
    vim_api.nvim_set_option_value('efm', efm, { buf = out_buf })
  else
    vim_api.nvim_buf_set_lines(out_buf, 0, -1, false, {})
  end

  vim_api.nvim_buf_set_name(out_buf, os.date 'build [%y-%m-%d %H:%M:%S]')

  local args = vim_fn.expandcmd(opts.args)
  local cmd = string.gsub(mp, '%$%*', args)

  local function write_out_buf(_, data, _)
    local len = #data
    local first = data[1]

    if first ~= '' then
      -- part of the previous line
      line_parts[#line_parts + 1] = first
    elseif len == 1 and #line_parts ~= 0 then
      -- data is [''], handle EOF
      out[#out + 1] = table_concat(line_parts)
      if out_buf ~= nil then
        nvim_buf_set_text(out_buf, -1, -1, -1, -1, { out[#out], '' })
      end
      return
    end

    if data[2] ~= nil then
      -- complete the previous line
      if #line_parts ~= 0 then
        out[#out + 1] = table_concat(line_parts)
        if out_buf ~= nil then
          nvim_buf_set_text(out_buf, -1, -1, -1, -1, { out[#out], '' })
        end
      end

      -- push lines
      for i = 2, len - 1 do
        out[#out + 1] = data[i]
        if out_buf ~= nil then
          nvim_buf_set_text(out_buf, -1, -1, -1, -1, { out[#out], '' })
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

    local items = (vim_fn.getqflist {
      efm = efm,
      lines = out,
    }).items
    out = {}

    local valid_items = {}
    local n = 1
    for i = 1, #items do
      local item = items[i]
      if item.valid == 1 and item.bufnr > 0 then
        valid_items[n] = items[i]
        n = n + 1
      end
    end

    vim_fn.setqflist(valid_items)
    vim_api.nvim_exec_autocmds({ 'QuickFixCmdPost' }, {})
    line_parts = {}
    BUILD_JOB_ID = nil
  end

  BUILD_JOB_ID = vim_fn.jobstart(cmd, {
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
    vim_api.nvim_win_set_buf(0, out_buf)
  end
end, { nargs = '*', bang = true })

k.map('n', 'M', function()
  vim_api.nvim_feedkeys(':M ', 'n', false)
end)
