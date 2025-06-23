local function win_buf(win)
  return vim.api.nvim_win_get_buf(win)
end

local function buf_opt(buf, opt)
  return vim.api.nvim_get_option_value(opt, { buf = buf })
end

return {
  win_buf = win_buf,
  buf_opt = buf_opt,
}
