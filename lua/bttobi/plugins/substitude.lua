return {
    "gbprod/substitute.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local substitute = require("substitute")

      substitute.setup()

      local map = vim.keymap

      map.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
      map.set("n", "ss", substitute.line, { desc = "Substitute line" })
      map.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
      map.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
    end,
  }
