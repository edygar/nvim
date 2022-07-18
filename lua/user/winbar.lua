local status_ok, winbar = pcall(require, "winbar")
if not status_ok then
  return
end

local icons = require "user.icons"

winbar.setup {
  enabled = true,
  show_file_path = true,
  show_symbols = true,
  icons = {
    file_icon_default = "",
    seperator = icons.ui.ChevronRight,
    editor_state = "●",
    lock_icon = "",
  },
}
