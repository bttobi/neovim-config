vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("v", "jk", "<ESC>", { desc = "Exit visual mode" })
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open a new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- moving lines
map("n", "<A-Up>", ":MoveLine -1<CR>", opts)
map("n", "<A-Down>", ":MoveLine 1<CR>", opts)
map("n", "<A-S-Left>", ":MoveWord -1<CR>", opts)
map("n", "<A-S-Right>", ":MoveWord 1<CR>", opts)

map("x", "<A-Up>", ":MoveBlock -1<CR>", opts)
map("x", "<A-Down>", ":MoveBlock 1<CR>", opts)
map("v", "<A-Left>", ":MoveHBlock -1<CR>", opts)
map("v", "<A-Right>", ":MoveHBlock 1<CR>", opts)

--mac os alt
map("n", "Ż", ":MoveLine -1<CR>", opts)
map("n", "∆", ":MoveLine 1<CR>", opts)
map("n", "<S-ķ>", ":MoveWord -1<CR>", opts)
map("n", "<S-ł>", ":MoveWord 1<CR>", opts)

map("x", "Ż", ":MoveBlock 1<CR>", opts)
map("x", "∆", ":MoveBlock -1<CR>", opts)
map("v", "ķ", ":MoveHBlock -1<CR>", opts)
map("v", "ł", ":MoveHBlock 1<CR>", opts)

--toggle color picker
map("n", "<leader>cp", function()
	require("minty.huefy").open()
end, { desc = "toggle color hues picker" })
map("n", "<leader>cs", function()
	require("minty.shades").open()
end, { desc = "toggle color shades picker" })

--context menu
map("n", "<C-t>", function()
	require("menu").open("default", { border = true })
end, {})

map("n", "<RightMouse>", function()
	vim.cmd.exec('"normal! \\<RightMouse>"')

	local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
	require("menu").open(options, { mouse = true, border = true })
end, {})

--foldings
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:⏷,foldsep: ,foldclose:⏵]]

--noice messages
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Messages" })

--tabufline
-- Switch to the next buffer with Tab
map("n", "<Tab>", function()
	require("nvchad.tabufline").next()
end, { noremap = true, silent = true })

-- Switch to the previous buffer with Shift + Tab
map("n", "<S-Tab>", function()
	require("nvchad.tabufline").prev()
end, { noremap = true, silent = true })

-- Move buffer to left
-- TODO:
map("n", "<Tab>l", function()
	require("nvchad.tabufline").move_buf(1)
end, { noremap = true, silent = true })

-- Move buffer to right
map("n", "<Tab>h", function()
	require("nvchad.tabufline").move_buf(-1)
end, { noremap = true, silent = true })

-- Close the current buffer with Leader + x
map("n", "<leader>x", function()
	require("nvchad.tabufline").close_buffer()
end, { noremap = true, silent = true, desc = "Close current buffer" })

-- Close all buffers
map("n", "<leader>xa", function()
	require("nvchad.tabufline").closeAllBufs(true)
end, { noremap = true, silent = true, desc = "Close all buffers" })

--terminal splits
map("n", "<leader>h", function()
	require("nvchad.term").new({ pos = "sp", size = 0.2 })
end, { noremap = true, silent = true, desc = "Horizontal terminal split" }) -- horizontal terminal split

map("n", "<leader>v", function()
	require("nvchad.term").new({ pos = "vsp", size = 0.2 })
end, { noremap = true, silent = true, desc = "Vertical terminal split" }) -- vertical terminal split

--terminal modes
vim.api.nvim_set_keymap("t", "<C-x>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

--theme picker
map("n", "<leader>th", function()
	require("nvchad.themes").open({ style = "flat", border = true })
end, { noremap = true, silent = true, desc = "Open theme picker" })

--cheatsheet
map("n", "<leader>ch", ":NvCheatsheet<CR>", { noremap = true, silent = true, desc = "Open cheatsheet" })

--harpoon
--TODO: add harpoon mappings

--paste persist cursor position
map("n", "p", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd("put")
	vim.api.nvim_win_set_cursor(0, { row + 1, col })
end)
