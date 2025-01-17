local M = {}

M.config = function()
  require("tmux").setup {
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
      -- enables copy sync and overwrites all register actions to
      -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
      enable = false,
    },
    navigation = {
      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = true,
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = true,

      -- sets resize steps for x axis
      resize_step_x = 2,

      -- sets resize steps for y axis
      resize_step_y = 2,
    },
  }
end

return M
