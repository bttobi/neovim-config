return  {
    "nvchad/base46",
    event = "VeryLazy",
    build = function()
      require("base46").load_all_highlights()
    end,
 }
