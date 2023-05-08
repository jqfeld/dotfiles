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
  use {
    'arnarg/todotxt.nvim',
    -- requires = {'MunifTanjim/nui.nvim'},
  }

  use { 'edluffy/hologram.nvim',
    config = function()
      require('hologram').setup {
        auto_display = true -- WIP automatic markdown image display, may be prone to breaking
      }
    end

  }
  -- Style plugins
  use { "sainnhe/gruvbox-material" }
  use { "kyazdani42/nvim-web-devicons" }
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icons
  --   },
  --   tag = 'nightly',                  -- optional, updated every week. (see issue #1193)
  --   config = function()
  --     require("nvim-tree").setup({
  --       filters = {
  --         dotfiles = true,
  --       },
  --     })
  --   end,
  -- }
  use { "romgrk/barbar.nvim", requires = { "kyazdani42/nvim-web-devicons" } }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          icons_enabled = true,
        },
        sections = {
          lualine_a = { { 'mode', upper = true } },
          lualine_b = { { 'branch', icon = '' } },
          lualine_c = { { 'filename', file_status = true } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      }
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
      }
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
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
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

  use {
    "numToStr/FTerm.nvim",
    config = function()
      require("FTerm").setup({
        dimensions = {
          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5
        },
        border = 'rounded'
      })
    end
  }

  use { "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end
  }

  use {
    'stevearc/aerial.nvim',
    requires = { { 'folke/which-key.nvim' } },
    config = function()
      require('aerial').setup({
        close_on_select = true,
        on_attach = function(bufnr)
          local wk = require("which-key")

          wk.register({
            name = "LSP",
            l = {
              o = { "<CMD>:AerialToggle float<CR>", "Outline" },
            }
          }, { prefix = "<Leader>" })
        end
      })
    end
  }

  use { 'p00f/nvim-ts-rainbow' }

  use { 'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "julia", "rust", "lua", "c", "make", "latex", "markdown", "todotxt" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
      }
    end
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
  -- use { 'rafamadriz/friendly-snippets' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/nvim-cmp',
    config = function()
      require('config.cmp')
    end
  }
  use { 'L3MON4D3/LuaSnip',
    config = function()
      require('config.snippets')
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

  use {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  }

  -- Neorg
  use {
    "nvim-neorg/neorg",
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                work = "~/Work/Notes",
                personal = "~/Notes",
              },
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
        },
      }
    end,
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Dev projects
  use { 'jqfeld/watson.nvim',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' } },
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end }
