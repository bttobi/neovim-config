return {
	"mgierada/lazydocker.nvim",
	dependencies = { "akinsho/toggleterm.nvim" },
	config = function()
		require("lazydocker").setup({
			border = "curved",
		})
	end,
	event = "BufRead",
	keys = {
		{
			"<leader>ld",
			function()
				require("lazydocker").open()
			end,
			desc = "Open lazy docker",
		},
	},
}
