return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					relculright = true,
					segments = {
						{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
	},
	event = "BufReadPost",
	opts = {
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
	},

	init = function()
		local map = vim.keymap
		map.set("n", "zR", function()
			require("ufo").openAllFolds()
		end)
		map.set("n", "zM", function()
			require("ufo").closeAllFolds()
		end)
	end,
}
