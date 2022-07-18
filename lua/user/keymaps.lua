M = {}
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("n", "<Space>", "", opts)
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
vim.api.nvim_set_keymap("n", "K", ":lua require('user.keymaps').show_documentation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<tab>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)

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

-- GIT Chunks
keymap("n", "[g", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opts)
keymap("n", "]g", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opts)

-- Plugins
keymap("n", "<leader>u", "<cmd>UndotreeToggle<CR>", opts)

-- ============================
-- Shortcuts for everyday tasks
-- ============================

-- copy current filename into system clipboard
-- this is helpful to paste someone the path you're looking at
-- Mnemonic: (c)urrent (f)ull filename (Eg.: ~/.yadr/nvim/settings/vim-keymaps.vim)
keymap("n", "<leader>cf", "<cmd>let @* = expand('%:~')<CR>", opts)
-- Mnemonic: (c)urrent (r)elative filename (Eg.: nvim/settings/vim-keymaps.vim)
keymap("n", "<leader>cr", "<cmd>let @* = expand('%')<CR>", opts)
-- Mnemonic: (c)urrent (n)ame of the file (Eg.: vim-keymaps.vim)
keymap("n", "<leader>cn", "<cmd>let @* = expand('%:t')<CR>", opts)

-- (v)im (r)eload
keymap("n", "<leader>vr", '<cmd>lua require("user.reload").reload()<CR>', opts)

-- Visual --
-- Move text up and down
keymap("v", "p", '"_dP', opts)

-- Tmux
keymap("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
keymap("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", opts)
keymap("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", opts)
keymap("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", opts)
-- keymap("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", opts);

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], term_opts)
keymap("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], term_opts)
keymap("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], term_opts)
keymap("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], term_opts)

-- Custom
keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)
keymap("n", "Q", "<cmd>Bdelete!<CR>", opts)
keymap("n", "<C-q>", "<cmd>lua require('user.functions').smart_quit()<CR>", opts)
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)
keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)

keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)

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

return M
