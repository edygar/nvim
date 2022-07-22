local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end
hop.setup()

local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader><leader>", "<cmd>HopWord<cr>", { silent = true })
keymap("v", "<leader><leader>", "<cmd>HopWord<cr>", { silent = true })
