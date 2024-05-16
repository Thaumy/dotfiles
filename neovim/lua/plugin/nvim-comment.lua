local k = require 'infra.keymap'
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
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "nix" then
      vim.api.nvim_buf_set_option(buf, "commentstring", "# %s")
    end
  end
}

-- nvim-comment:
-- toggle comment
k.map_cmd('v', 'm', 'CommentToggle')
