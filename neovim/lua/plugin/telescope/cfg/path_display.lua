require 'infra.lang_ext'

local function path_display(_, path)
  local name = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)

  if parent == '.' then
    return name
  end

  if string.start_with(parent, './') then
    parent = string.skip(parent, 3)
  end

  return string.format('%s\t%s', name, parent)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'TelescopeResults',
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd('TelescopeFileParent', '\t.*$')
      vim.api.nvim_set_hl(0, 'TelescopeFileParent', { link = 'NonText' })
    end)
  end,
})

return path_display
