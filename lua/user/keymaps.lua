M = {}
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
keymap("n", "<C-i>", "<C-i>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window management
-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Window organization
keymap("n", "<leader>vv", "<cmd>vsplit<cr>", opts)
keymap("n", "<leader>ss", "<cmd>split<cr>", opts)
-- resize window with arrows
keymap("n", "<Up>", ":resize +1<CR>", opts)
keymap("n", "<Down>", ":resize -1<CR>", opts)
keymap("n", "<Left>", "<C-w><", opts)
keymap("n", "<Right>", "<C-w>>", opts)


-- Tabs --
keymap("n", "tt", ":tabedit<cr>", opts)
keymap("n", "tk", ":tabprevious<cr>", opts)
keymap("n", "tj", ":tabnext<cr>", opts)
keymap("n", "tc", ":tabclose<cr>", opts)
-- keymap("n", [[c-\]], ":tabonly<cr>", opts)

-- Cycling Lists --
-- Buffers
keymap("n", "[b", "<Plug>(CybuPrev)", opts)
keymap("n", "]b", "<Plug>(CybuNext)", opts)
-- Quickfix
keymap("n", "[q", "<cmd>QPrev<CR>", opts)
keymap("n", "]q", "<cmd>QNext<CR>", opts)

-- Jumplist
keymap("n", "[j", "<C-o>", opts)
keymap("n", "]j", "<C-i>", opts)

-- Visual --
-- Move text up and down
keymap("v", "p", '"_dP', opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Custom
keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)
keymap("n", "Q", "<cmd>Bdelete!<CR>", opts)
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)
keymap(
  "n",
  "<C-p>",
  "<cmd>Telescope find_files<CR>",
  opts
)

keymap("n", "-", ":lua require'lir.float'.toggle()<cr>", opts)
-- keymap("n", "<C-\\>", "<cmd>vsplit<cr>", opts)
-- vim.cmd[[nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]
-- vim.cmd[[nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]
-- keymap("n", "c*", [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]], opts)
-- keymap("n", "c#", [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]], opts)
-- keymap("n", "gx", [[:execute '!brave ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
-- Change '<CR>' to whatever shortcut you like :)

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end
vim.api.nvim_set_keymap("n", "K", ":lua require('user.keymaps').show_documentation()<CR>", opts)

return M
