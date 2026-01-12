local shorten_path = require 'infra.shorten_path'
local plugin = require 'lualine'

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
  local mode_code = vim.api.nvim_get_mode().mode
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
  local format = vim.bo.fileformat
  if format == 'unix' then
    return 'LF'
  elseif format == 'mac' then
    return 'CR'
  else -- dos
    return 'CRLF'
  end
end

local function visual_chars()
  local wc = vim.fn.wordcount()
  if wc.visual_chars ~= nil then
    return string.format('󰒉 %d', wc.visual_chars)
  else
    return ''
  end
end

local function col()
  return string.format('C%d', vim.api.nvim_win_get_cursor(0)[2])
end

local function relative_path()
  if vim.bo.buftype ~= '' then return '' end

  local path = shorten_path(vim.api.nvim_buf_get_name(0))

  if vim.bo.readonly or (not vim.bo.modifiable) then
    return string.format('%s RO', path)
  elseif vim.bo.modified then
    return string.format('%s M', path)
  else
    return string.format('%s S', path)
  end
end

plugin.setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { { 'branch', color = { fg = '#4C4F69', bg = '#d3d7e0' } } },
    lualine_c = { relative_path, visual_chars },
    lualine_x = { 'searchcount', col, 'encoding', file_format },
    lualine_y = { { lsp_name, color = { fg = '#4C4F69', bg = '#d3d7e0' } } },
    lualine_z = {},
  },
}
