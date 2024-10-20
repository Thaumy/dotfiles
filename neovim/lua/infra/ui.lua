local function win_buf(win)
  return vim.api.nvim_win_get_buf(win)
end

local function buf_opt(buf, opt)
  return vim.api.nvim_get_option_value(opt, { buf = buf })
end

local function any_ft_buf(ft)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf_opt(buf, 'filetype') == ft then return true end
  end
  return false
end


return {
  win_buf = win_buf,
  buf_opt = buf_opt,
  any_ft_buf = any_ft_buf,
}
