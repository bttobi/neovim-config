local options = {
  base46 = {
    theme = "bearded-arc", -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {},
    transparency = false,
    theme_toggle = { "bearded-arc"},
  },
telescope = { style = "bordered" }, -- borderless / bordered

    statusline = {
      enabled = true,
      theme = "default", -- default/vscode/vscode_colored/minimal
      separator_style = "block",
      order = nil,
      modules = nil,
    },
    colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
