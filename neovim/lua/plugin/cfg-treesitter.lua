local function setup()
	require 'nvim-treesitter.configs'.setup {
		highlight = {
			enable = true,
		}
	}
end

return setup()
