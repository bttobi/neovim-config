return {
  "petertriho/nvim-scrollbar",
  cond = not vim.g.vscode,
  dependencies = {
    "lewis6991/gitsigns.nvim",
  },
  opts = {
    handle = {
      text = " ",
      blend = 0,
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
  },
}
