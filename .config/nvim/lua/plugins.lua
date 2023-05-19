-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- auto install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

-- HACK: Some problems with packer during first start of neovim -> uncomment this
-- after plugins are installed display can be set interactive again
--[[ require('packer').init({
    display = {
        non_interactive = true,
    }
}) ]]
return require('packer').startup { function(use)
  -- Packer can manage itself as an optional plugin
  use { 'wbthomason/packer.nvim' }

  -- Style plugins
  use { "sainnhe/gruvbox-material" }
  use { "kyazdani42/nvim-web-devicons" }
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' } }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope-symbols.nvim' }

  use {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {
        highlight = {
          comments_only = false,
        },
      }
    end
  }
  use { 'yamatsum/nvim-cursorline',
    config = function()
      vim.g.cursorword_highlight = 1
    end
  }

  use { "numToStr/FTerm.nvim" }

  use {
    'stevearc/aerial.nvim',
    requires = { { 'folke/which-key.nvim' } },
  }

  use { 'p00f/nvim-ts-rainbow' }

  use { 'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use { 'nvim-treesitter/playground' }

  use({ "neovim/nvim-lspconfig", })
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("flutter-tools").setup {}
    end
  }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' } }
  }
  use { 'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip').config.setup({
        enable_autosnippets = true,
      })
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- Rust
  use { 'mfussenegger/nvim-dap' }

  -- Julia
  use { 'JuliaEditorSupport/julia-vim' }
  use { 'hkupty/iron.nvim' }


  -- Tables
  use { 'dhruvasagar/vim-table-mode' }

  -- Git
  use { 'TimUntersberger/neogit',
    config = function()
      require 'neogit'.setup {}
    end
  }

  use {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim" -- optional
    },
  }

  -- Neorg
  use {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Dev projects
  use {
    'jqfeld/watson.nvim',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' } },
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end }
