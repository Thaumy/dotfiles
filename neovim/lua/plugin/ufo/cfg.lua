local k = require 'infra.key'
local plugin = require 'ufo'

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local function fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰜮 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

plugin.setup {
  fold_virt_text_handler = fold_virt_text_handler,
}

-- fold code block
k.map('n', '<M-k>', function()
  if vim.bo.ft == 'TelescopePrompt' then
    return
  end
  vim.api.nvim_feedkeys('za', 'n', true)
end)
-- expand code block
k.map('n', '<M-j>', function()
  if vim.bo.ft == 'TelescopePrompt' then
    return
  end
  vim.api.nvim_feedkeys('zo', 'n', true)
end)
