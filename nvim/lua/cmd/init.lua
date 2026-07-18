require 'cmd.make'
require 'cmd.hl_ref'
require 'cmd.ccapture'
require 'cmd.case_conv'
require 'cmd.im_switch'
require 'cmd.hl_conflict'
require 'cmd.hl_trailing_space'

-- disable auto comment in normal mode
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'o' }
  end,
})

-- limit qf window height
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  callback = vim.schedule_wrap(function()
    local win = vim.fn.getqflist { winid = 0 }.winid
    if win == 0 then return end
    local buf = vim.api.nvim_win_get_buf(win)
    local line_count = vim.api.nvim_buf_line_count(buf)
    -- height range: [3, 10]
    local height = math.max(3, math.min(line_count, 10))
    vim.api.nvim_win_set_height(win, height)
  end),
})
