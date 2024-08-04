return {
	"laytan/tailwind-sorter.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
	build = "cd formatter && npm ci && npm run build",
	config = function()
		require("tailwind-sorter").setup({
			on_save_enabled = false,
			on_save_pattern = { "*.html", "*.js", "*.jsx", "*.tsx", "*.twig", "*.hbs", "*.php", "*.heex", "*.astro" },
			node_path = "node",
		})
	end,
}
