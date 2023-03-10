local vim = vim

local function setup()
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.expandtab = true
	vim.bo.softtabstop = 2

	-- show line numbers
	vim.wo.number = true
	vim.o.cmdheight = 0

	-- single status line
	vim.opt.laststatus = 3
end

return setup()
