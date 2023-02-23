local function setup()
	require "lualine".setup {
		options = {
			icons_enabled = false,
			colorscheme = "catppuccin",
			component_separators = { left = '|', right = '|' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = { 'NvimTree' }
		},
	}
end

return setup()
