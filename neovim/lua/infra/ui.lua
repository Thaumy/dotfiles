local function any_buf_ft(ft)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local it = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if it == ft then
      return true
    end
  end
  return false
end

local function curr_buf_ft()
  local buf = vim.api.nvim_get_current_buf()
  return vim.api.nvim_get_option_value('filetype', { buf = buf })
end

local function win_bt(win)
  local buf = vim.api.nvim_win_get_buf(win)
  return vim.api.nvim_get_option_value('buftype', { buf = buf })
end

local function win_ft(win)
  local buf = vim.api.nvim_win_get_buf(win)
  return vim.api.nvim_get_option_value('filetype', { buf = buf })
end

return {
  any_buf_ft = any_buf_ft,
  curr_buf_ft = curr_buf_ft,
  win_bt = win_bt,
  win_ft = win_ft,
}
