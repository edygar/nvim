local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Have packer use a popup window
packer.init {}

-- Install your plugins here
local falsy = function()
  return false
end

return packer.startup(function(_use)
  local essential = true
  local use = function(opts)
    if type(opts) == "string" then
      opts = { opts }
    end

    if not essential then
      opts["cond"] = falsy
    end

    _use(opts)
  end

  use { "lewis6991/impatient.nvim" }
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used ny lots of plugins
  use { "numToStr/Comment.nvim" } -- Toggle comments with ease
  use { "christoomey/vim-tmux-navigator" } --  Seamless navigation between vim and tmux windows
  use { "phaazon/hop.nvim" }
  use { "moll/vim-bbye" }
  use { "austintaylor/vim-indentobject" } -- indentation as textobj
  use { "tpope/vim-unimpaired" } -- Mappings for e[ e] q[ q] l[ l], etc
  use { "tpope/vim-repeat" } -- Repeat last command
  use { "kylechui/nvim-surround" } -- Surround "" ()
  use { "nacro90/numb.nvim" } -- Peek line while :__
  use { "NvChad/nvim-colorizer.lua" }
  use { "RRethy/vim-illuminate" }

  if MINIMAL then
    essential = false
  end

  -- My plugins here
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "hoob3rt/lualine.nvim"

  use "vim-scripts/lastpos.vim" -- Passive. Last position jump improved.
  use "akinsho/toggleterm.nvim"
  use "lukas-reineke/indent-blankline.nvim"

  use "mbbill/undotree" -- Visualize your Vim undo tree
  use "monaqa/dial.nvim" --
  use "windwp/nvim-spectre" -- Search text panel
  use "kevinhwang91/nvim-bqf"
  use "ThePrimeagen/harpoon"
  use "MattesGroeger/vim-bookmarks"
  use "stevearc/qf_helper.nvim"

  use { "michaelb/sniprun", run = "bash ./install.sh" }
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- UI
  use "stevearc/dressing.nvim"
  use "ghillb/cybu.nvim"
  use "tversteeg/registers.nvim"
  use "rcarriga/nvim-notify"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use "folke/zen-mode.nvim"
  use "folke/todo-comments.nvim"
  use "andymass/vim-matchup"
  use "is0n/jaq-nvim"

  -- Colorschemes
  use "lunarvim/onedarker.nvim"

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" }
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "zbirenbaum/copilot-cmp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "simrat39/symbols-outline.nvim"
  use "ray-x/lsp_signature.nvim"
  use "b0o/SchemaStore.nvim"
  use "folke/trouble.nvim"
  use "github/copilot.vim"
  use "stevearc/aerial.nvim"
  use "j-hui/fidget.nvim"

  -- TODO: set this up
  -- use "rmagatti/goto-preview"
  use "nvim-lua/lsp_extensions.nvim"

  -- Java
  use "mfussenegger/nvim-jdtls"

  -- Rust
  use { "christianchiarulli/rust-tools.nvim", branch = "handler_nil_check" }
  use "Saecki/crates.nvim"

  -- Typescript TODO: set this up, also add keybinds to ftplugin
  use "jose-elias-alvarez/typescript.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"
  -- use "drybalka/tree-climber.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "mattn/webapi-vim"

  -- DAP
  use "mfussenegger/nvim-dap"
  -- use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  -- use "Pocco81/DAPInstall.nvim"

  -- Plugin Graveyard
  -- use "mizlan/iswap.nvim"
  -- use {'christianchiarulli/nvim-ts-rainbow'}
  -- use "nvim-telescope/telescope-ui-select.nvim"
  -- use "nvim-telescope/telescope-file-browser.nvim"
  -- use 'David-Kunz/cmp-npm' -- doesn't seem to work
  -- use "lunarvim/vim-solidity"
  -- use "tpope/vim-repeat"
  -- use "Shatur/neovim-session-manager"
  -- use "metakirby5/codi.vim"
  -- use { "nyngwang/NeoZoom.lua", branch = "neo-zoom-original" }
  -- use "rcarriga/cmp-dap"
  -- use "filipdutescu/renamer.nvim"
  -- use "https://github.com/rhysd/conflict-marker.vim"
  -- use "rebelot/kanagawa.nvim"
  -- use "unblevable/quick-scope"
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "gbprod/cutlass.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
