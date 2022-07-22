local M = {}

M.winbar_filetype_exclude = {
  "Cybu",
  "DressingSelect",
  "Jaq",
  "NvimTree",
  "Outline",
  "Trouble",
  "aerial",
  "alpha",
  "dap-repl",
  "dap-terminal",
  "dapui_breakpoints",
  "dapui_console",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
  "dashboard",
  "fugitive",
  "gitcommit",
  "harpoon",
  "help",
  "minpacprgs",
  "neo-tree",
  "neogitstatus",
  "nofile",
  "packer",
  "qf",
  "spectre_panel",
  "startify",
  "toggleterm",
  "whichkey",
}

local aerial = require "aerial"
local devicon = require "nvim-web-devicons"
local icons = require "user.icons"
local sep = " " .. icons.ui.ChevronRight .. " "

-- Format the list representing the symbol path
-- Grab it from https://github.com/stevearc/aerial.nvim/blob/master/lua/lualine/components/aerial.lua
local function format_symbols(symbols, depth, separator, icons_enabled)
  local parts = {}
  depth = depth or #symbols

  if depth > 0 then
    symbols = { unpack(symbols, 1, depth) }
  else
    symbols = { unpack(symbols, #symbols + 1 + depth) }
  end

  for _, symbol in ipairs(symbols) do
    if icons_enabled then
      table.insert(parts, "%#Aerial" .. symbol.kind .. "Icon#" .. symbol.icon .. "%*" .. symbol.name)
    else
      table.insert(parts, symbol.name)
    end
  end

  return table.concat(parts, separator)
end

local function get_symbol_path()
  -- Get a list representing the symbol path by aerial.get_location (see
  -- https://github.com/stevearc/aerial.nvim/blob/master/lua/aerial/init.lua#L127),
  -- and format the list to get the symbol path.
  -- Grab it from
  -- https://github.com/stevearc/aerial.nvim/blob/master/lua/lualine/components/aerial.lua#L89
  local symbols = aerial.get_location(true)
  local symbol_path = format_symbols(symbols, nil, sep, true)
  return symbol_path == "" and "" or symbol_path
end

local function get_win_num()
  local win_num = vim.api.nvim_win_get_number(0)
  -- Whether the current window is a maximized one (by maximized.nvim)
  local maximized = vim.t.maximized and "   " or ""
  return " " .. win_num .. maximized .. sep
end

local function get_file_icon_and_name()
  local filename = vim.fn.expand "%:t"
  local file_icon, file_icon_color = devicon.get_icon_color_by_filetype(vim.bo.filetype, { default = true })
  vim.api.nvim_set_hl(0, "WinbarFileIcon", { fg = file_icon_color })
  return "%#WinbarFileIcon#" .. file_icon .. "%* " .. filename
end

local function get_modified()
  local modified = vim.api.nvim_eval_statusline("%m", {}).str
  return modified == "" and "" or " %#Normal#" .. modified .. "%*"
end

M.winbar = function()
  local win_num = get_win_num()

  for _, ft in pairs(M.winbar_filetype_exclude) do
    if vim.bo.filetype == ft then
      return ""
    end
  end

  local path = vim.fn.expand "%:~:.:h"
  local symbol_path = get_symbol_path()
  local file_icon_and_name = get_file_icon_and_name()
  local modified = get_modified()

  return table.concat({ win_num .. " %<" .. path, file_icon_and_name .. modified, symbol_path }, sep)
end

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function(args)
    local buf = vim.bo[args.buf]

    if buf.filetype == "" then
      vim.opt_local.winbar = nil
      return
    end

    local exluded_filetype = vim.tbl_contains(M.winbar_filetype_exclude, buf.filetype)
    local excluded_buftype = vim.tbl_contains(M.winbar_filetype_exclude, buf.buftype)

    if exluded_filetype or excluded_buftype then
      vim.opt_local.winbar = nil
    else
      vim.opt_local.winbar = "%{%v:lua.require('user.winbar').winbar()%}"
    end
  end,
})

return M
