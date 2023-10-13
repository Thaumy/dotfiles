local lspcfg = require "lspconfig"

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function setup()
	lspcfg.hls.setup {
		capabilities = capabilities,
	}
	lspcfg.rnix.setup {
		capabilities = capabilities,
	}
	lspcfg.html.setup {
		capabilities = capabilities,
	}
	--lspcfg.sqls.setup {
	--	capabilities = capabilities,
	--}
	lspcfg.taplo.setup {
		capabilities = capabilities,
	}
	lspcfg.jdtls.setup {
		capabilities = capabilities,
		cmd = { "jdt-language-server" },
	}
	lspcfg.gopls.setup {
		capabilities = capabilities,
	}
	lspcfg.cssls.setup {
		capabilities = capabilities,
	}
	lspcfg.texlab.setup {
		capabilities = capabilities,
	}
	lspcfg.bashls.setup {
		capabilities = capabilities,
	}
	lspcfg.jsonls.setup {
		capabilities = capabilities,
	}
	lspcfg.clangd.setup {
		capabilities = capabilities,
	}
	--lspcfg.denols.setup {
	--	capabilities = capabilities,
	--}
	lspcfg.yamlls.setup {
		capabilities = capabilities,
	}
	lspcfg.pyright.setup {
		capabilities = capabilities,
	}
	--lspcfg.marksman.setup {
	--	capabilities = capabilities,
	--}
	lspcfg.omnisharp.setup {
		cmd = { "OmniSharp" },
		capabilities = capabilities,
	}
	lspcfg.lua_ls.setup {
		capabilities = capabilities,
	}
	lspcfg.rust_analyzer.setup {
		capabilities = capabilities,
	}
	lspcfg.fsautocomplete.setup {
		capabilities = capabilities,
		cmd = { "fsautocomplete", "--adaptive-lsp-server-enabled" },
	}
	lspcfg.kotlin_language_server.setup {
		capabilities = capabilities,
	}
end

return setup()
