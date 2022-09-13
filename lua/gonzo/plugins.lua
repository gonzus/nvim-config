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
  print "Installing packer -- close and reopen neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Could not require module 'packer'")
  return
end

local status_util_ok, packer_util = pcall(require, "packer.util")
if status_util_ok then
  -- Have packer use a popup window
  packer.init {
    display = {
      open_fn = function()
        return packer_util.float { border = "rounded" }
      end,
    },
  }
end

-- Install your plugins here
return packer.startup(function(use)
  -- basic plugins
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "RRethy/vim-illuminate" -- auto-highlighting

  -- color schemes
  use "lunarvim/darkplus.nvim" -- really nice

  -- Zig
  use "ziglang/zig.vim"

  -- git
  use "lewis6991/gitsigns.nvim" -- show git worldview next to line numbers

  -- nvim-tree
  use {
    'kyazdani42/nvim-tree.lua', -- an explorer-like interface
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- snazzy buffer line
  use {
    'akinsho/bufferline.nvim', -- show buffer / file names on top
    tag = "v2.*",
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- cmp: a completion engine
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- LSP completions
  use "hrsh7th/cmp-nvim-lua" -- support lua for configuring nvim

  -- snippets -- required by cmp
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP -- language server protocol
  use { "williamboman/mason.nvim" } -- mason LSP loader
  use { "williamboman/mason-lspconfig.nvim" } -- mason configuration
  use "neovim/nvim-lspconfig" -- enable LSP

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
