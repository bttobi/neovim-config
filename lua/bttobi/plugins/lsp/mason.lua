return {
	"williamboman/mason.nvim",
	dependencies = {
		"nvim-java/nvim-java",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason_tool_installer = require("mason-tool-installer")

		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
			},
		})
	end,
}
