-- auto switch fcitx

local lib = LIBNVIMCFG

-- fcitx5 dbus is broken under root user
if vim.env.USER == 'root' then return end

local im_switch = lib.im_switch_new()
if im_switch == nil then return end

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    lib.im_switch_activate(im_switch)
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    lib.im_switch_deactivate(im_switch)
  end,
})
