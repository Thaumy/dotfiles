local events = require 'neo-tree.events'

return {
  {
    event = events.BEFORE_RENDER,
    handler = function()
      if vim.bo.filetype ~= 'neo-tree' then
        return
      end
      -- disable line number
      vim.cmd.setlocal 'nonumber'
      -- fix colorscheme highlight
      vim.cmd.setlocal 'winhighlight=Normal:NeoTreeNormal,NormalNC:NeoTreeNormalNC,SignColumn:NeoTreeSignColumn,CursorLine:NeoTreeCursorLine,FloatBorder:NeoTreeFloatBorder,StatusLine:NeoTreeStatusLine,StatusLineNC:NeoTreeStatusLineNC,VertSplit:NeoTreeVertSplit,EndOfBuffer:NeoTreeEndOfBuffer,WinSeparator:NeoTreeWinSeparator'
    end,
  },
}
