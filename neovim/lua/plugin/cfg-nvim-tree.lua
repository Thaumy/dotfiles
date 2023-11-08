local vim = vim

local function resize_nvim_tree()
  local ratio = 28 / 100
  local width = math.floor(vim.go.columns * ratio)
  vim.cmd("tabdo NvimTreeResize " .. width)
end

local function setup()
	require "nvim-tree".setup {
		sort_by = "case_sensitive",
		view = {
			--width = 30,
			signcolumn = "no"
		},
		hijack_cursor = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
	}

  resize_nvim_tree()
  vim.api.nvim_create_autocmd({ "VimResized" }, {
      group = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true }),
      callback = resize_nvim_tree,
  })
end

return setup()
