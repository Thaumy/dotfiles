local function setup()
	require "nvim-tree".setup {
		sort_by = "case_sensitive",
		view = {
			width = 30,
			signcolumn = "no"
		},
		hijack_cursor = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
	}
end

return setup()
