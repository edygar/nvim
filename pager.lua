require "user.keymaps"
require "user.options"
require "user.colorscheme"

vim.cmd [[
  packadd hop.nvim
  packadd vim-indentobject
  packadd numb.nvim

  set shell=bash
  set nocursorline
  set signcolumn=no
  set laststatus=0
  set nonu
  set norelativenumber

  nmap <silent> q :qa!<CR>
  nmap <silent> i :qa!<CR>
  nmap <silent> I :qa!<CR>
  autocmd TermEnter * stopinsert
  autocmd TermClose * normal G
]]

require("hop").setup()
