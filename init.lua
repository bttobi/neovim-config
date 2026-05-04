-- TODO: move configs, keymaps etc to separate files
-- PLUGINS
vim.pack.add {
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" }, -- tmux & split window navigation
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvchad/base46" },
  { src = "https://github.com/nvchad/ui" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/mlaursen/vim-react-snippets" },
  { src = "https://github.com/antosha417/nvim-lsp-file-operations" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-cmdline" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0", build = "make install_jsregexp" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/onsails/lspkind.nvim" },
  { src = "https://github.com/JavaHello/spring-boot.nvim", version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/microsoft/vscode-js-debug" },
  { src = "https://github.com/mxsdev/nvim-dap-vscode-js" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/hiphish/rainbow-delimiters.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://github.com/nvim-java/nvim-java" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/rmagatti/auto-session" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/mgierada/lazydocker.nvim" },
  { src = "https://github.com/esmuellert/codediff.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  {
    src = "https://github.com/iamcco/markdown-preview.nvim",
  },
  { src = "https://github.com/lewis6991/async.nvim" },
  { src = "https://github.com/ThePrimeagen/refactoring.nvim" },
  {
    src = "https://github.com/kylechui/nvim-surround",
    version = vim.version.range "4.x",
  },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/petertriho/nvim-scrollbar" },
  { src = "https://github.com/goolord/alpha-nvim" },
}

-- PLUGIN CONFIGS
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
}

local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local capabilities = cmp_nvim_lsp.default_capabilities()

if not configs.kotlin_lsp then
  configs.kotlin_lsp = {
    default_config = {
      cmd = { "kotlin-lsp", "--stdio" },
      filetypes = { "kotlin" },
      root_dir = lspconfig.util.root_pattern("settings.gradle.kts", "build.gradle.kts", "settings.gradle", ".git"),
      single_file_support = false,
    },
  }
end

require("mason").setup {
  ui = {
    check_outdated_packages_on_open = false,
  },
  registries = { "github:nvim-java/mason-registry", "github:mason-org/mason-registry" },
}

require("mason-lspconfig").setup {
  ensure_installed = {
    "ts_ls",
    "html",
    "cssls",
    "tailwindcss",
    "svelte",
    "lua_ls",
    "emmet_ls",
    "prismals",
    "pyright",
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
    end,
    jdtls = function()
      require("java").setup()
      lspconfig["jdtls"].setup {
        capabilities = capabilities,
      }
    end,
    ["emmet_ls"] = function()
      -- configure emmet language server
      lspconfig["emmet_ls"].setup {
        capabilities = capabilities,
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "svelte",
        },
      }
    end,
    ["lua_ls"] = function()
      -- configure lua server (with special settings)
      lspconfig["lua_ls"].setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }
    end,
  },
}

lspconfig.kotlin_lsp.setup {
  capabilities = capabilities,
}

local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
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
}

-- telescope.load_extension "fzf"

require("oil").setup {
  columns = { "icon" },
  view_options = { show_hidden = true },
}
require("auto-session").setup {
  auto_restore_enabled = false,
  auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Desktop/" },
}

require("nvim-ts-autotag").setup {
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = true, -- Auto close on trailing </
  },
}

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-tool-installer").setup {
  ensure_installed = {
    "prettierd",
    "stylua",
    "isort",
    "black",
    "pylint",
    "eslint_d",
  },
}

require("conform").setup {
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
    timeout_ms = 1000,
    lsp_fallback = true,
    async = false,
  },
}

require("java").setup()
vim.lsp.enable "jdtls"

local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"
--require("vim-react-snippets").lazy_load()
require("luasnip.loaders.from_vscode").load()
local options = {
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = false },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    format = lspkind.cmp_format {
      maxwidth = 50,
      ellipsis_char = "...",
    },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}
options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")
cmp.setup(options)

-- Search completion
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Command completion
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

require("nvim-autopairs").setup {
  check_ts = true, -- enable treesitter
  ts_config = {
    lua = { "string" }, -- don't add pairs in lua string treesitter nodes
    javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
    java = false, -- don't check treesitter on java
  },
}

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

-- dap
local dap = require "dap"
-- local dapui = require "dapui"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
  },
}

for _, adapter in pairs { "pwa-node", "pwa-chrome" } do
  dap.adapters[adapter] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "js-debug-adapter",
      args = { "${port}" },
    },
  }
end

local enter_launch_url = function()
  local co = coroutine.running()
  return coroutine.create(function()
    vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
      if url == nil or url == "" then
        return
      else
        coroutine.resume(co, url)
      end
    end)
  end)
end

for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file using Node.js (nvim-dap)",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process using Node.js (nvim-dap)",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    -- requires ts-node to be installed globally or locally
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file using Node.js with ts-node/register (nvim-dap)",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeArgs = { "-r", "ts-node/register" },
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome (nvim-dap)",
      url = enter_launch_url,
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
    },
    {
      type = "pwa-msedge",
      request = "launch",
      name = "Launch Edge (nvim-dap)",
      url = enter_launch_url,
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
    },
  }
end

dap.adapters.java = {
  type = "server",
  host = "127.0.0.1",
  port = 5005,
}

dap.configurations.kotlin = {
  {
    type = "java",
    request = "attach",
    name = "Attach to Kotlin JVM (Spring Boot / Gradle)",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

-- vscode-js dap
-- TODO: make this work
require("dap-vscode-js").setup {
  debugger_path = vim.fn.stdpath "data" .. "/site/pack/core/start/vscode-js-debug",
  adapters = {
    "pwa-node",
    "pwa-chrome",
    "pwa-msedge",
    "node-terminal",
    "pwa-extensionHost",
  },
}

-- codediff
require("codediff").setup {}

-- lazydocker
require("lazydocker").setup { border = "curved" }

-- nvim-lint
local lint = require "lint"
require("lint").linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  python = { "pylint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- tiny-diagnostics
require("tiny-inline-diagnostic").setup()
vim.diagnostic.config { virtual_text = false }

-- todo-comments
local todo_comments = require "todo-comments"
todo_comments.setup()

-- indent-blankline
local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = {
  highlight = highlight,
  query = { tsx = "rainbow-parens", jsx = "rainbow-parens" },
  blacklist = { "html", "xml" },
}
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

-- refactoring.nvim
require("refactoring").setup {}

-- trouble.nvim
require("trouble").setup {}

-- markdown-preview
vim.fn["mkdp#util#install"]()
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- plugin is already loaded, so nothing required
  end,
})

-- nvim-scrollbar
require("scrollbar").setup {
  handle = {
    text = " ",
    blend = 0,
    color = "gray",
    highlight = "CursorColumn",
    hide_if_all_visible = true,
  },

  handlers = {
    gitsigns = true,
  },

  marks = {
    Search = {
      text = { "▬", "=" },
      color = "yellow",
    },
    Error = {
      text = { "▬", "=" },
      color = "#e02828",
    },
    Warn = {
      text = { "▬", "=" },
      color = "#e09738",
    },
    Info = {
      text = { "▬", "=" },
      color = "#38cdeb",
    },
    Hint = {
      text = { "▬", "=" },
      color = "#4222f5",
    },
    GitAdd = {
      text = "+",
      highlight = "GitSignsAdd",
      color = "green",
    },
    GitChange = {
      text = "~",
      highlight = "GitSignsChange",
      color = "white",
    },
    GitDelete = {
      text = "x",
      highlight = "GitSignsDelete",
      color = "red",
    },
  },
}

-- alpha-nvim
local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"
local tobiHeader = {
  "                                 ",
  "  ████████╗ ██████╗ ██████╗ ██╗  ",
  "  ╚══██╔══╝██╔═══██╗██╔══██╗██║  ",
  "     ██║   ██║   ██║██████╔╝██║  ",
  "     ██║   ██║   ██║██╔══██╗██║  ",
  "     ██║   ╚██████╔╝██████╔╝██║  ",
  "     ╚═╝    ╚═════╝ ╚═════╝ ╚═╝  ",
  "                                 ",
}

dashboard.section.header.val = tobiHeader
dashboard.section.buttons.val = {
  dashboard.button("e", "📄  > New file", "<cmd>ene<CR>"),
  dashboard.button("SPC ee", "📑  > Toggle file explorer", "<cmd>Oil<CR>"),
  dashboard.button("SPC ff", "🔍  > Find file", "<cmd>Telescope find_files<CR>"),
  dashboard.button("SPC fs", "👀  > Find word", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("SPC ft", "✅  > Find TODO", "<cmd>TodoTelescope<CR>"),
  dashboard.button("SPC wr", "🔄  > Restore session for current directory", "<cmd>AutoSession restore<CR>"),
  dashboard.button("q", "❌  > Quit NVIM", ":qa<CR>"),
}
alpha.setup(dashboard.opts)

vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]

-- render ui plugins
require "nvchad"
require("base46").load_all_highlights()

-- OPTIONS
vim.cmd "let g:netrw_liststyle = 3"

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs and indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append "unnamedplus" -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- KEYMAPS
vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ":", ";", { desc = "Re-do movement" })
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
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("n", "<A-j>", ":m .+1<CR>==", opts)

-- moving blocks
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)

-- moving lines -MAC OS
map("n", "Ż", ":m .-2<CR>==", opts)
map("n", "∆", ":m .+1<CR>==", opts)

-- moving blocks -MAC OS
map("x", "Ż", ":m '<-2<CR>gv=gv", opts)
map("x", "∆", ":m '>+1<CR>gv=gv", opts)

--context menu
map("n", "<C-t>", function()
  require("menu").open("default", { border = true })
end, {})

map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true, border = true })
end, {})

-- auto-session
map("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
map("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" })

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
--
-- -- Switch to the previous buffer with Shift + Tab
map("n", "<S-Tab>", function()
  require("nvchad.tabufline").prev()
end, { noremap = true, silent = true })
--
-- -- Move buffer to left
-- -- TODO:
-- map("n", "<Tab>l", function()
-- 	require("nvchad.tabufline").move_buf(1)
-- end, { noremap = true, silent = true })
--
-- -- Move buffer to right
-- map("n", "<Tab>h", function()
-- 	require("nvchad.tabufline").move_buf(-1)
-- end, { noremap = true, silent = true })

-- Close the current buffer with Leader + x
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { noremap = true, silent = true, desc = "Close current buffer" })
--
-- -- Close all buffers
map("n", "<leader>xa", function()
  require("nvchad.tabufline").closeAllBufs(true)
end, { noremap = true, silent = true, desc = "Close all buffers" })
--
--terminal splits
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp", size = 0.2 }
end, { noremap = true, silent = true, desc = "Horizontal terminal split" }) -- horizontal terminal split

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp", size = 0.2 }
end, { noremap = true, silent = true, desc = "Vertical terminal split" }) -- vertical terminal split

--terminal modes
vim.api.nvim_set_keymap("t", "<C-x>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

--theme picker
map("n", "<leader>tp", function()
  require("nvchad.themes").open { style = "flat", border = true }
end, { noremap = true, silent = true, desc = "Open theme picker" })

--cheatsheet
map("n", "<leader>ch", ":NvCheatsheet<CR>", { noremap = true, silent = true, desc = "Open cheatsheet" })

--paste persist cursor position
map("n", "p", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd "put"
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end)

--DAP
-- map("n", "<leader>dt", function()
--   require("dapui").toggle()
-- end, { noremap = true, silent = true, desc = "Toggle DAP UI" })
map("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, silent = true, desc = "Toggle DAP breakpoint" })
map("n", "<leader>dc", ":DapContinue<CR>", { noremap = true, silent = true, desc = "DAP continue" })
map("n", "<leader>dq", ":DapTerminate<CR>", { noremap = true, silent = true, desc = "DAP terminate" })
map("n", "<leader>dr", ":DapToggleRepl<CR>", { noremap = true, silent = true, desc = "DAP toggle REPL" })
map("n", "<Down>", ":DapStepOver<CR>", { noremap = true, silent = true, desc = "DAP step over" })
map("n", "<Right>", ":DapStepInto<CR>", { noremap = true, silent = true, desc = "DAP step into" })
map("n", "<Left>", ":DapStepOut<CR>", { noremap = true, silent = true, desc = "DAP step out" })
map("n", "<Up>", ":DapRestartFrame<CR>", { noremap = true, silent = true, desc = "DAP restart frame" })

--Refactoring
map("x", "<leader>re", ":Refactor extract ", { noremap = true, silent = true, desc = "Refactor extract" })
map(
  "x",
  "<leader>rf",
  ":Refactor extract_to_file ",
  { noremap = true, silent = true, desc = "Refactor extract to a file" }
)

map("x", "<leader>rv", ":Refactor extract_var ", { noremap = true, silent = true, desc = "Refactor extract variable" })

map(
  { "n", "x" },
  "<leader>ri",
  ":Refactor inline_var",
  { noremap = true, silent = true, desc = "Refactor inline variable" }
)

map("n", "<leader>rI", ":Refactor inline_func", { noremap = true, silent = true, desc = "Refactor inline function" })

map("n", "<leader>rb", ":Refactor extract_block", { noremap = true, silent = true, desc = "Refactor extract block" })
map(
  "n",
  "<leader>rbf",
  ":Refactor extract_block_to_file",
  { noremap = true, silent = true, desc = "Refactor extract block to file" }
)

-- formatting
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  }
end, { desc = "Format file or range (in visual mode)" })

-- telescope

local function close_all_buffers()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
map("n", "<leader>xa", function()
  close_all_buffers()
  print "All buffers closed!"
end, { desc = "Close all buffers using Telescope" })

-- oil
map("n", "<C-n>", "<cmd>Oil<cr>", { desc = "Open parent directory oil nvim" })
map("n", "<leader>ee", "<cmd>Oil<cr>", { desc = "Open parent directory oil nvim" })

-- lazygit
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })

-- lazydocker
map("n", "<leader>ld", function()
  require("lazydocker").open()
end, { desc = "Open lazy docker" })

-- codediff
map("n", "<leader>cd", "<cmd>CodeDiff<cr>", { desc = "Open Code diff view" })

-- lint
map("n", "<leader>l", function()
  require("lint").try_lint()
end, { desc = "Trigger linting for current file" })

-- gitsigns
local gs = require "gitsigns"
map("n", "]h", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gs.nav_hunk "next"
  end
end, { desc = "Next hunk" })

map("n", "[h", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gs.nav_hunk "prev"
  end
end, { desc = "Previous hunk" })
map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
map("v", "<leader>hs", function()
  gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Stage hunk" })
map("v", "<leader>hr", function()
  gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Reset hunk" })
map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
map("v", "<leader>hb", function()
  gs.blame_line { full = true }
end, { desc = "Blame line" })
map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
map("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
map("v", "<leader>hD", function()
  gs.diff_this "~"
end, { desc = "Diff this ~" })
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns select hunk" })

-- todo-comments
map("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })

-- trouble.nvim
map("n", "<leader>xx", "<cmd>Trouble<CR>", { desc = "Open/close trouble list" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" })
map(
  "n",
  "<leader>xd",
  "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
  { desc = "Open trouble document diagnostics" }
)
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
map("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })

-- AUTOCOMMANDS
vim.cmd "syntax off"
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    opts.desc = "Show LSP references"
    map("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Go to declaration"
    map("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Show LSP definitions"
    map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Show LSP implementations"
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "Show LSP type definitions"
    map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "See available code actions"
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart rename"
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show buffer diagnostics"
    map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show line diagnostics"
    map("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to previous diagnostic"
    map("n", "[d", vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to next diagnostic"
    map("n", "]d", vim.diagnostic.goto_next, opts)

    opts.desc = "Show documentation for what is under cursor"
    map("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Restart LSP"
    map("n", "<leader>rs", ":LspRestart<CR>", opts)
  end,
})
