local map = require 'infra.key'.map
local vim_api = vim.api

RECORDING = false

local function refresh_lualine()
  if VVP_MODE then return end
  require 'lualine'.refresh {
    force = true,
    scope = 'window',
    place = { 'statusline' },
  }
end

local keys = {}
local play = ''
local play_readable = ''
local ns = vim_api.nvim_create_namespace 'better-recording'

map({ 'n', 'x' }, 'rj', function()
  if RECORDING then return end

  keys = {}
  RECORDING = true
  refresh_lualine()

  vim.on_key(function(_, typed)
    if typed == 'rj' or typed == 'rk' then
      vim.on_key(nil, ns)

      play = table.concat(keys)
      play_readable = vim.fn.keytrans(play)
      vim.print(string.format('recorded: [%s]', play_readable))

      RECORDING = false
      refresh_lualine()

      return '' -- discard to avoid re-entry
    elseif typed ~= '' and typed ~= 'ri' then
      keys[#keys + 1] = typed
    end
  end, ns)
end)

map({ 'n', 'x' }, 'rk', function()
  if RECORDING then return end

  vim_api.nvim_input(play)
  vim.schedule(function()
    vim.print(string.format('played: [%s]', play_readable))
  end)
end)
