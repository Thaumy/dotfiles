local vim = vim

local function setup()
	require "catppuccin".setup {
		flavour = "mocha",
		color_overrides = {
			all = {
				surface1 = "#313240",
			},
		},
	}
	vim.cmd.colorscheme "catppuccin"
end

return setup()
