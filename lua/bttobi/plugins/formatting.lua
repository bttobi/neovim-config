return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				typescript = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				graphql = { "prettierd" },
				python = { "isort", "black" },
			},

			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 1000,
				lsp_fallback = true,
				async = false,
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>fm", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
