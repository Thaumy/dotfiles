local k = require 'infra.key'
local plugin = require 'nvim_comment'

plugin.setup {
  -- Linters prefer comment and line to have a space in between markers
  marker_padding = true,
  -- should comment out empty or whitespace only lines
  comment_empty = false,
  -- trim empty comment whitespace
  comment_empty_trim_whitespace = false,
  -- Should key mappings be created
  create_mappings = false,
  -- Normal mode mapping left hand side
  line_mapping = '',
  -- Visual/Operator mapping left hand side
  operator_mapping = '',
  -- text object mapping, comment chunk,,
  comment_chunk_text_object = '',
  -- Hook function to call before commenting takes place
  hook = function()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')

    if
        ft == 'nix' or
        ft == 'conf'
    then
      vim.api.nvim_buf_set_option(buf, 'commentstring', '# %s')
      return
    end

    if
        ft == 'typst'
    then
      vim.api.nvim_buf_set_option(buf, 'commentstring', '// %s')
      return
    end
  end,
}

-- toggle comment
k.map('v', 'm', function()
  local line_start = vim.fn.line 'v'
  local line_end = vim.fn.getcurpos()[2]
  local range
  if line_start > line_end then
    range = { line_end, line_start }
  else
    range = { line_start, line_end }
  end
  vim.cmd { cmd = 'CommentToggle', range = range }
end)
