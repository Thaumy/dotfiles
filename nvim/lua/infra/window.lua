local function open_float(buf, width, height)
  local row
  local n_or_s
  local top_border = ' '
  local bottom_border = ' '
  if vim.fn.winline() + height + 1 < vim.api.nvim_win_get_height(0) then
    row = 1
    n_or_s = 'N'
    top_border = ''
  else
    row = 0
    n_or_s = 'S'
    bottom_border = ''
  end

  local col
  local w_or_e
  if vim.fn.wincol() + width + 1 < vim.api.nvim_win_get_width(0) then
    col = 1
    w_or_e = 'W'
  else
    col = 0
    w_or_e = 'E'
  end

  return vim.api.nvim_open_win(buf, false, {
    relative = 'cursor',
    anchor = n_or_s .. w_or_e,
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = { ' ', top_border, ' ', ' ', ' ', bottom_border, ' ', ' ' },
  })
end

return {
  open_float = open_float,
}
