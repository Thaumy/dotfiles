local vim = vim

local function setup()
	require "todo-comments".setup {
		keywords = {
			-- BUG:
			FIX  = { icon = "B", alt = { "BUG" } },
			-- TODO:
			TODO = { icon = "T" },
			-- HACK:
			HACK = { icon = "H" },
			-- WARN:
			WARN = { icon = "W" },
			-- PERF:
			PERF = { icon = "P" },
			-- INFO:
			NOTE = { icon = "I", alt = { "INFO" } },
			-- TEST:
			TEST = { icon = "T" },
		},
	}

	vim.opt.termguicolors = true
end

return setup()
