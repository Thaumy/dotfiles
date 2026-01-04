local k = require 'infra.key'

local enable_inlay_hint = true

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspProgress' }, {
  callback = function()
    if enable_inlay_hint then
      vim.lsp.inlay_hint.enable()
    end
  end,
})

k.map('n', 'tt', function()
  enable_inlay_hint = not enable_inlay_hint
  vim.lsp.inlay_hint.enable(enable_inlay_hint)
end)

vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  severity_sort = true,
}
vim.o.updatetime = 300

local hover_buf = nil
local diagnostic_buf = nil

-- show diagnostic
do
  local ns = vim.api.nvim_create_namespace 'diagnostic-win'
  local on_cursor_moved = nil
  k.map('n', '<M-w>', function()
    diagnostic_buf = vim.diagnostic.open_float { scope = 'cursor' }

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
        if diagnostic_buf ~= nil and vim.api.nvim_buf_is_valid(diagnostic_buf) then
          vim.api.nvim_buf_delete(diagnostic_buf, {})
        end
        if on_cursor_moved ~= nil then
          vim.api.nvim_del_autocmd(on_cursor_moved)
          on_cursor_moved = nil
        end
        vim.on_key(nil, ns)
      end
    end, ns)
  end
  )
end

-- show def
do
  local ns = vim.api.nvim_create_namespace 'lsp-hover-win'
  local on_cursor_moved = nil
  -- See: https://neovim.io/doc/user/lsp.html#lsp-handler
  vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
    if err ~= nil or result == nil or result.contents == nil then return end

    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)

    -- show macro expansion for Rust
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client.name == 'rust_analyzer' then
      local ret = client:request_sync('rust-analyzer/expandMacro', ctx.params)
      if ret ~= nil and ret.err == nil and ret.result ~= nil then
        lines[#lines + 1] = '---'
        lines[#lines + 1] = '```rust'
        vim.list_extend(lines, vim.split(ret.result.expansion, '\n', { trimempty = true }))
        lines[#lines + 1] = '```'
      end
    end

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
    local client = vim.lsp.get_clients { bufnr = 0 }[1]
    if client == nil then
      vim.notify 'no LSP'
      return
    end
    client:request('textDocument/hover', vim.lsp.util.make_position_params(0, client.offset_encoding))

    -- close diagnostic buf when show def
    if diagnostic_buf ~= nil and vim.api.nvim_buf_is_valid(diagnostic_buf) then
      vim.api.nvim_buf_delete(diagnostic_buf, {})
      diagnostic_buf = nil
    end
  end)
end

-- fmt
k.map('n', 'fm', function()
  if
      vim.bo.buftype ~= '' or
      vim.bo.readonly or
      (not vim.bo.modifiable)
  then
    return
  end

  if vim.bo.ft == 'markdown' then
    vim.cmd 'Neoformat denofmt'
  else
    vim.lsp.buf.format { sync = true }
  end

  vim.cmd 'w'
end)

-- rename
k.map('n', 'tr', vim.lsp.buf.rename)
