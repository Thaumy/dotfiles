local k = require 'infra.key'
local window = require 'infra.window'

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

local diagnostic_buf = nil

-- show diagnostic
do
  local ns = vim.api.nvim_create_namespace 'diagnostic-win'
  local on_cursor_moved = nil
  k.map('n', '<M-w>', function()
    diagnostic_buf = vim.diagnostic.open_float {
      scope = 'cursor',
      border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    }

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
  local ns = vim.api.nvim_create_namespace 'lsp-doc'
  local dash80 = string.rep('─', 80)

  local doc_win = nil
  local doc_buf = nil
  local autocmd = nil

  local function close_doc()
    if doc_win == nil then return end

    vim.api.nvim_win_close(doc_win, false)
    doc_win = nil
    vim.api.nvim_buf_delete(doc_buf, {})
    doc_buf = nil
  end

  -- See: https://neovim.io/doc/user/lsp.html#lsp-handler
  vim.lsp.handlers['textDocument/hover'] = function(err, result)
    if err ~= nil or result == nil or result.contents == nil then return end

    result.contents.value = result.contents.value:gsub('\n%-%-%-\n', '---')
    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)

    if vim.tbl_isempty(lines) then
      vim.notify 'no docs'
      return
    end

    doc_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(doc_buf, 0, -1, true, lines)
    vim.api.nvim_set_option_value('modifiable', false, { buf = doc_buf })
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = doc_buf })
    vim.api.nvim_create_autocmd({ 'BufLeave' }, {
      once = true,
      buffer = doc_buf,
      callback = close_doc,
    })

    local doc_width = 0
    for i, line in ipairs(lines) do
      if line == '---' then
        vim.api.nvim_buf_set_extmark(doc_buf, ns, i - 1, 0, {
          virt_text = { { dash80, 'NonText' } },
          virt_text_pos = 'overlay',
        })
      end

      if doc_width < 80 then
        if #line >= 80 then
          doc_width = 80
        elseif #line > doc_width then
          doc_width = #line
        end
      end
    end

    doc_win = window.open_float(doc_buf, doc_width, 1)
    vim.api.nvim_set_option_value('wrap', true, { win = doc_win })
    vim.api.nvim_set_option_value('conceallevel', 2, { win = doc_win })

    local doc_height = vim.api.nvim_win_text_height(doc_win, {
      max_height = math.floor(vim.o.lines * 0.5) - 3,
    }).all
    vim.api.nvim_win_set_height(doc_win, doc_height)

    if autocmd == nil then
      autocmd = vim.api.nvim_create_autocmd(
        { 'CursorMoved', 'BufLeave', 'ModeChanged', 'WinScrolled' },
        {
          once = true,
          buffer = vim.api.nvim_get_current_buf(),
          callback = function()
            vim.api.nvim_del_autocmd(autocmd)
            autocmd = nil
            vim.on_key(nil, ns)
            close_doc()
          end,
        })
    end

    vim.on_key(function(key, _)
      vim.on_key(nil, ns)
      -- if <Esc> was pressed
      if key == '\27' then close_doc() end
    end, ns)
  end

  k.map('n', '<M-a>', function()
    if doc_win ~= nil then
      if autocmd ~= nil then
        vim.api.nvim_del_autocmd(autocmd)
        autocmd = nil
      end
      vim.api.nvim_set_current_win(doc_win)
      return
    end

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
    vim.print 'can not fmt special buffer'
    return
  end

  if
      vim.bo.readonly or
      (not vim.bo.modifiable)
  then
    vim.print 'can not fmt RO buffer'
    return
  end

  if vim.bo.ft == 'markdown' then
    vim.cmd 'Neoformat denofmt'
  else
    vim.lsp.buf.format { sync = true }
  end

  if vim.api.nvim_buf_get_name(0) == '' then
    vim.print 'no filename, can not write'
    return
  end

  vim.cmd 'w'
end)

-- rename
k.map('n', 'tr', vim.lsp.buf.rename)
