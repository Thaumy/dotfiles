-- auto switch fcitx

-- fcitx5 dbus is broken under root user
if vim.env.USER == 'root' then return end

local fcitx_state = nil

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if fcitx_state == '2\n' then
      os.execute 'fcitx5-remote -o'
    end
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    local handle = io.popen 'fcitx5-remote'
    if handle == nil then return end
    fcitx_state = handle:read 'a'
    handle:close()
    os.execute 'fcitx5-remote -c'
  end,
})
