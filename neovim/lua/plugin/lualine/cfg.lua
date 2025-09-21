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
  local client = vim.lsp.get_clients { bufnr = 0 }[1]
  if client == nil then
    return ''
  else
    return client.messages.name
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

local function readonly()
  if vim.bo.readonly or (not vim.bo.modifiable) then
    return 'RO'
  else
    return ''
  end
end

local function visual_chars()
  local wc = vim.fn.wordcount()
  if wc.visual_chars ~= nil then
    return string.format('VC%d', wc.visual_chars)
  else
    return ''
  end
end

local function col()
  return string.format('C%d', vim.api.nvim_win_get_cursor(0)[2])
end

local function relative_path()
  return vim.fn.expand '%:.'
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
    lualine_c = { relative_path, 'diagnostics', readonly, visual_chars },
    lualine_x = { 'searchcount', col, 'encoding', file_format },
    lualine_y = { { lsp_name, color = { fg = '#4C4F69', bg = '#d3d7e0' } } },
    lualine_z = {},
  },
}
