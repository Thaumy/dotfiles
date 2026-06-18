local k = require 'infra.key'
local vim_o = vim.o
local vim_bo = vim.bo
local vim_api = vim.api
local vim_lsp = vim.lsp
local vim_diagnostic = vim.diagnostic
local window = require 'infra.window'
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark

local enable_inlay_hint = true

vim_api.nvim_create_autocmd({ 'LspAttach', 'LspProgress' }, {
  callback = function()
    if enable_inlay_hint then
      vim_lsp.inlay_hint.enable()
    end
  end,
})

k.map('n', 'tt', function()
  enable_inlay_hint = not enable_inlay_hint
  vim_lsp.inlay_hint.enable(enable_inlay_hint)
end)

vim_diagnostic.config {
  virtual_text = false,
  signs = false,
  severity_sort = true,
}
vim_o.updatetime = 300

local diagnostic_buf = nil

-- show diagnostic
do
  local ns = vim_api.nvim_create_namespace 'diagnostic-win'
  local on_cursor_moved = nil
  k.map('n', '<M-w>', function()
    diagnostic_buf = vim_diagnostic.open_float {
      scope = 'cursor',
      border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    }

    on_cursor_moved = vim_api.nvim_create_autocmd('CursorMoved', {
      once = true,
      callback = function()
        on_cursor_moved = nil
        vim.on_key(nil, ns)
      end,
    })
    vim.on_key(function(key, _)
      -- if <Esc> was pressed
      if key == '\27' then
        if diagnostic_buf ~= nil and vim_api.nvim_buf_is_valid(diagnostic_buf) then
          vim_api.nvim_buf_delete(diagnostic_buf, {})
        end
        if on_cursor_moved ~= nil then
          vim_api.nvim_del_autocmd(on_cursor_moved)
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
  local ns = vim_api.nvim_create_namespace 'lsp-doc'
  local dash80 = string.rep('─', 80)

  local doc_win = nil
  local doc_buf = nil
  local autocmd = nil

  local function close_doc()
    if doc_win == nil then return end

    vim_api.nvim_win_close(doc_win, false)
    doc_win = nil
    vim_api.nvim_buf_delete(doc_buf, {})
    doc_buf = nil
  end

  -- See: https://neovim.io/doc/user/lsp.html#lsp-handler
  vim_lsp.handlers['textDocument/hover'] = function(err, result)
    if err ~= nil or result == nil or result.contents == nil then return end

    result.contents.value = result.contents.value:gsub('\n%-%-%-\n', '---')
    local lines = vim_lsp.util.convert_input_to_markdown_lines(result.contents)

    if vim.tbl_isempty(lines) then
      vim.notify 'no docs'
      return
    end

    doc_buf = vim_api.nvim_create_buf(false, true)
    vim_api.nvim_buf_set_lines(doc_buf, 0, -1, true, lines)
    vim_api.nvim_set_option_value('modifiable', false, { buf = doc_buf })
    vim_api.nvim_set_option_value('filetype', 'markdown', { buf = doc_buf })
    vim_api.nvim_create_autocmd({ 'BufLeave' }, {
      once = true,
      buffer = doc_buf,
      callback = close_doc,
    })

    local doc_width = 0
    for i, line in ipairs(lines) do
      if line == '---' then
        nvim_buf_set_extmark(doc_buf, ns, i - 1, 0, {
          virt_text = { { dash80, 'NonText' } },
          virt_text_pos = 'overlay',
        })
      end

      if doc_width < 80 then
        local line_len = #line
        if line_len >= 80 then
          doc_width = 80
        elseif line_len > doc_width then
          doc_width = line_len
        end
      end
    end

    doc_win = window.open_float(doc_buf, doc_width, 1)
    vim_api.nvim_set_option_value('wrap', true, { win = doc_win })
    vim_api.nvim_set_option_value('conceallevel', 2, { win = doc_win })

    local doc_height = vim_api.nvim_win_text_height(doc_win, {
      max_height = math.floor(vim_o.lines * 0.5) - 3,
    }).all
    vim_api.nvim_win_set_height(doc_win, doc_height)

    if autocmd == nil then
      autocmd = vim_api.nvim_create_autocmd(
        { 'CursorMoved', 'BufLeave', 'ModeChanged', 'WinScrolled' },
        {
          once = true,
          buffer = vim_api.nvim_get_current_buf(),
          callback = function()
            vim_api.nvim_del_autocmd(autocmd)
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
        vim_api.nvim_del_autocmd(autocmd)
        autocmd = nil
      end
      vim_api.nvim_set_current_win(doc_win)
      return
    end

    local client = vim_lsp.get_clients { bufnr = 0 }[1]
    if client == nil then
      vim.notify 'no LSP'
      return
    end
    client:request('textDocument/hover', vim_lsp.util.make_position_params(0, client.offset_encoding))

    -- close diagnostic buf when show def
    if diagnostic_buf ~= nil and vim_api.nvim_buf_is_valid(diagnostic_buf) then
      vim_api.nvim_buf_delete(diagnostic_buf, {})
      diagnostic_buf = nil
    end
  end)
end

-- fmt
k.map('n', 'fm', function()
  if vim_bo.buftype ~= '' then
    vim.print 'can not fmt special buffer'
    return
  end

  if
      vim_bo.readonly or
      (not vim_bo.modifiable)
  then
    vim.print 'can not fmt RO buffer'
    return
  end

  if vim_bo.ft == 'markdown' then
    vim.cmd 'Neoformat denofmt'
  else
    vim_lsp.buf.format { sync = true }
  end

  if vim_api.nvim_buf_get_name(0) == '' then
    vim.print 'no filename, can not write'
    return
  end

  vim.cmd 'w'
end)

-- rename
k.map('n', 'tr', vim_lsp.buf.rename)
