local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
  return
end

local icons = require "user.icons"

navic.setup {
  icons = icons,
  highlight = true,
  separator = " " .. icons.ui.ChevronRight .. " ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  text_hl = "Winbar",
}

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
