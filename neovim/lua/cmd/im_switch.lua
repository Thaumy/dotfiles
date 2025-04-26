-- auto switch fcitx

-- fcitx5 dbus is broken under root user
if vim.env.USER == 'root' then return end

local activate_next = false

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if activate_next then
      vim.system { 'fcitx5-remote', '-o' }
    end
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    local obj = vim.system({ 'fcitx5-remote' }, { text = true }):wait()
    activate_next = obj.stdout == '2\n'
    vim.system { 'fcitx5-remote', '-c' }
  end,
})
