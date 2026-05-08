local lib = LIBNVIMCFG
local vim_api = vim.api

-- fcitx5 dbus is broken under root user
if vim.env.USER == 'root' then return end

local im_switch = lib.im_switch_new()
if im_switch == nil then return end

vim_api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    lib.im_switch_activate(im_switch)
  end,
})

vim_api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    lib.im_switch_deactivate(im_switch)
  end,
})
