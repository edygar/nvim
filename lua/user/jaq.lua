M = {}
local status_ok, jaq_nvim = pcall(require, "jaq-nvim")
if not status_ok then
  return
end

jaq_nvim.setup {
  -- Commands used with 'Jaq'
  cmds = {
    -- Default UI used (see `Usage` for options)
    default = "term",

    -- Uses external commands such as 'g++' and 'cargo'
    external = {
      typescript = "deno run %",
      javascript = "node %",
      -- markdown = "glow %",
      python = "python %",
      -- rust = "rustc % && ./$fileBase && rm $fileBase",
      rust = "cargo run",
      cpp = "g++ % -o $fileBase && ./$fileBase",
      go = "go run %",
      sh = "sh %",
    },

    -- Uses internal commands such as 'source' and 'luafile'
    internal = {
      -- lua = "luafile %",
      -- vim = "source %",
    },
  },
  behavior = {
    -- Default type
    default = "terminal",

    -- Start in insert mode
    startinsert = false,

    -- Use `wincmd p` on startup
    wincmd = false,

    -- Auto-save files
    autosave = false,

    -- position = "vert",

    -- Open the terminal without line numbers
    -- line_no = false,
  },
  terminal = {
    -- Window position
    position = "vert",

    -- Window size
    size = 60,

    -- Disable line numbers
    line_no = false,
  },

  -- UI settings
  ui = {
    -- Start in insert mode
    startinsert = false,

    -- Switch back to current file
    -- after using Jaq
    wincmd = false,

    -- Auto-save the current file
    -- before executing it
    autosave = true,

    -- Floating Window / FTerm settings
    float = {
      -- Floating window border (see ':h nvim_open_win')
      border = "none",

      -- Num from `0 - 1` for measurements
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5,

      -- Highlight group for floating window/border (see ':h winhl')
      border_hl = "FloatBorder",
      float_hl = "Normal",

      -- Floating Window Transparency (see ':h winblend')
      blend = 0,
    },

    terminal = {
      -- Position of terminal
      position = "vert",

      -- Open the terminal without line numbers
      line_no = false,

      -- Size of terminal
      size = 60,
    },
  },
}

return M
