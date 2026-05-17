local plugin = require 'lualine'
local vim_bo = vim.bo
local vim_fn = vim.fn
local vim_api = vim.api
local shorten_path = require 'infra.shorten_path'

local map = {
  ['n']     = 'NOR',
  ['no']    = 'O-P',
  ['nov']   = 'O-P',
  ['noV']   = 'O-P',
  ['no\22'] = 'O-P',
  ['niI']   = 'NOR',
  ['niR']   = 'NOR',
  ['niV']   = 'NOR',
  ['nt']    = 'NOR',
  ['ntT']   = 'NOR',
  ['v']     = 'VIS',
  ['vs']    = 'VIS',
  ['V']     = 'V-L',
  ['Vs']    = 'V-L',
  ['\22']   = 'V-B',
  ['\22s']  = 'V-B',
  ['s']     = 'SEL',
  ['S']     = 'S-L',
  ['\19']   = 'S-B',
  ['i']     = 'INS',
  ['ic']    = 'INS',
  ['ix']    = 'INS',
  ['R']     = 'REP',
  ['Rc']    = 'REP',
  ['Rx']    = 'REP',
  ['Rv']    = 'V-R',
  ['Rvc']   = 'V-R',
  ['Rvx']   = 'V-R',
  ['c']     = 'CMD',
  ['cv']    = 'E X',
  ['ce']    = 'E X',
  ['r']     = 'REP',
  ['rm']    = 'MOR',
  ['r?']    = 'CON',
  ['!']     = 'S H',
  ['t']     = 'TRM',
}

local function mode()
  local mode_code = vim_api.nvim_get_mode().mode
  local mode_text = map[mode_code]
  if mode_text == nil then
    return mode_code
  else
    return mode_text
  end
end

local function lsp_name()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  local len = #clients

  if len == 0 then
    return ''
  elseif len == 1 then
    return clients[1].messages.name
  else
    return '󰒋 ' .. len
  end
end

local function file_format()
  local format = vim_bo.fileformat
  if format == 'unix' then
    return 'LF'
  elseif format == 'mac' then
    return 'CR'
  else -- dos
    return 'CRLF'
  end
end

local function visual_chars()
  local type = vim_api.nvim_get_mode().mode
  if
      type ~= 'v' and -- by char
      type ~= 'V' and -- by line
      type ~= '\22'   -- by block
  then
    return ''
  end

  local from = vim_fn.getpos 'v'
  local to = vim_fn.getpos '.'
  local selected = vim_fn.getregion(from, to, { type = type })

  local count = 0
  for _, line in ipairs(selected) do
    count = count + vim_fn.strchars(line)
  end

  return string.format('󰒉 %d', count)
end

local function build_state()
  if BUILD_JOB_ID ~= nil then
    return '󰞌 B'
  else
    return ''
  end
end

local function col()
  local n = vim_api.nvim_win_get_cursor(0)[2]
  if n < 80 then
    return string.format('C%d', n)
  else
    return string.format('%%#WarningMsg#C%d', n)
  end
end

local function relative_path()
  if vim_bo.buftype ~= '' then return '' end

  local path = shorten_path(vim_api.nvim_buf_get_name(0))

  if vim_bo.readonly or (not vim_bo.modifiable) then
    return string.format('%s RO', path)
  elseif vim_bo.modified then
    return string.format('%s M', path)
  else
    return string.format('%s S', path)
  end
end

local recording = {
  function()
    if RECORDING then
      return 'REC'
    else
      return ''
    end
  end,
  color = 'Recording',
}

plugin.setup {
  options = {
    icons_enabled = false,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { mode, recording },
    lualine_b = { { 'branch', color = { fg = '#4C4F69', bg = '#d3d7e0' } } },
    lualine_c = { relative_path, visual_chars, build_state },
    lualine_x = { 'searchcount', col, 'encoding', file_format },
    lualine_y = { { lsp_name, color = { fg = '#4C4F69', bg = '#d3d7e0' } } },
    lualine_z = {},
  },
}
