vim.cmd.aunmenu [[PopUp.Cut]]
vim.cmd.aunmenu [[PopUp.Copy]]
vim.cmd.aunmenu [[PopUp.Paste]]
vim.cmd.aunmenu [[PopUp.Delete]]
vim.cmd.aunmenu [[PopUp.Select\ All]]
vim.cmd.aunmenu [[PopUp.Inspect]]
vim.cmd.aunmenu [[PopUp.-1-]]
vim.cmd.aunmenu [[PopUp.How-to\ disable\ mouse]]

vim.cmd.vmenu [[PopUp.Copy "+y]]
vim.cmd.vmenu [[PopUp.Paste "+P]]
vim.cmd.vmenu [[PopUp.Cut "+x]]
vim.cmd.vmenu [[PopUp.Delete "_x]]

vim.cmd.nmenu [[PopUp.Paste "+p]]
vim.cmd.nmenu [[PopUp.Select\ All va]]
vim.cmd.nmenu [[PopUp.-1- <Nop>]]
vim.cmd.nmenu [[PopUp.Callers <Cmd>lua require 'telescope.builtin'.lsp_incoming_calls()<Cr>]]
vim.cmd.nmenu [[PopUp.Type\ definitions <Cmd>lua require 'telescope.builtin'.lsp_type_definitions()<Cr>]]
vim.cmd.nmenu [[PopUp.Docuemnt\ symbols <Cmd>lua require 'telescope.builtin'.lsp_document_symbols()<Cr>]]
vim.cmd.nmenu [[PopUp.-2- <Nop>]]
vim.cmd.nmenu [[PopUp.Lazy <Cmd>Lazy<Cr>]]
vim.cmd.nmenu [[PopUp.Lsp\ info <Cmd>LspInfo<Cr>]]
vim.cmd.nmenu [[PopUp.Notifications <Cmd>Fidget history<Cr>]]
