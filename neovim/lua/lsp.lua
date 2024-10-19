local k = require 'infra.key'
local ui = require 'infra.ui'
local cmp = require 'cmp'

local function enable_inlay_hint()
  vim.lsp.inlay_hint.enable()
end
vim.api.nvim_create_autocmd('LspAttach', {
  callback = enable_inlay_hint,
})
vim.api.nvim_create_autocmd('LspProgress', {
  callback = enable_inlay_hint,
})

vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  severity_sort = true,
}
vim.o.updatetime = 300

local hover_buf = nil
local diagnostic_buf = nil

-- show diagnostic on hover
do
  local ns = vim.api.nvim_create_namespace 'diagnostic-hold'
  local cursor_still_hold = false
  local on_cursor_moved = nil
  vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
      if cursor_still_hold then return end
      if hover_buf ~= nil and vim.api.nvim_buf_is_valid(hover_buf) then return end
      if cmp.visible() then return end
      if diagnostic_buf ~= nil and vim.api.nvim_buf_is_valid(diagnostic_buf) then return end

      diagnostic_buf = vim.diagnostic.open_float { scope = 'cursor' }
      cursor_still_hold = true

      on_cursor_moved = vim.api.nvim_create_autocmd('CursorMoved', {
        once = true,
        callback = function()
          cursor_still_hold = false
          on_cursor_moved = nil
          vim.on_key(nil, ns)
        end,
      })
      vim.on_key(function(key, _)
        -- if <Esc> was pressed
        if key == '\27' then
          if diagnostic_buf ~= nil and vim.api.nvim_buf_is_valid(diagnostic_buf) then
            vim.api.nvim_buf_delete(diagnostic_buf, {})
          end
          vim.on_key(nil, ns)
        end
      end, ns)
    end,
  })
end

-- show def
do
  local ns = vim.api.nvim_create_namespace 'lsp-hover-win'
  local on_cursor_moved = nil
  -- See: https://neovim.io/doc/user/lsp.html#lsp-handler
  vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
    if err ~= nil or result == nil or result.contents == nil then return end

    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)

    if vim.tbl_isempty(lines) then
      vim.notify 'no docs'
      return
    end

    if config == nil then
      config = { focus_id = ctx.method }
    end
    hover_buf = vim.lsp.util.open_floating_preview(lines, 'markdown', config)

    on_cursor_moved = vim.api.nvim_create_autocmd('CursorMoved', {
      once = true,
      callback = function()
        on_cursor_moved = nil
        vim.on_key(nil, ns)
      end,
    })
    vim.on_key(function(key, _)
      -- if <Esc> was pressed
      if key == '\27' then
        if hover_buf ~= nil and vim.api.nvim_buf_is_valid(hover_buf) then
          vim.api.nvim_buf_delete(hover_buf, {})
        end
        if on_cursor_moved ~= nil then
          vim.api.nvim_del_autocmd(on_cursor_moved)
          on_cursor_moved = nil
        end
        vim.on_key(nil, ns)
      end
    end, ns)
  end

  k.map('n', '<M-a>', function()
    vim.lsp.buf.hover()

    -- close diagnostic buf when show def
    if diagnostic_buf ~= nil and vim.api.nvim_buf_is_valid(diagnostic_buf) then
      vim.api.nvim_buf_delete(diagnostic_buf, {})
      diagnostic_buf = nil
    end
  end)
end
-- fmt
k.map('n', 'fm', function()
  if ui.curr_buf_ft() == 'markdown' then
    vim.cmd 'Neoformat denofmt'
  else
    vim.lsp.buf.format { sync = true }
  end
end)
-- rename
k.map('n', 'tr', vim.lsp.buf.rename)
