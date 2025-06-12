return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["<C-d>"] = actions.delete_buffer,
					},
				},
			},
		})

		local function close_all_buffers()
			local bufs = vim.api.nvim_list_bufs()
			for _, buf in ipairs(bufs) do
				if vim.api.nvim_buf_is_loaded(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end

		telescope.load_extension("fzf")

		local map = vim.keymap -- for conciseness

		map.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		map.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		map.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		map.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		map.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
		map.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		map.set("n", "<leader>xa", function()
			close_all_buffers()
			print("All buffers closed!")
		end, { desc = "Close all buffers using Telescope" })
	end,
}
