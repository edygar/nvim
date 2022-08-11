local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

vim.api.nvim_create_user_command("Jest", function(opt)
  vim.cmd [[ :silent !tmux split-window -h -l "40\%" -d bash -c "npm test -- --watch %" ]]
end, { nargs = "?" })

local mappings = {
  L = {
    name = "TypeScript",
    r = { "<cmd>Jest<Cr>", "Run tests for current file" },
  },
}

which_key.register(mappings, opts)
