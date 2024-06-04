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

plugin.setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename', 'diagnostics' },
    lualine_x = { 'encoding', 'fileformat' },
    lualine_y = { 'searchcount', 'progress' },
    lualine_z = { 'location' },
  },
}
