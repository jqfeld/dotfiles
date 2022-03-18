-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- auto install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- HACK: Some problems with packer during first start of neovim -> uncomment this
-- after plugins are installed display can be set interactive again
--[[ require('packer').init({
    display = {
        non_interactive = true,
    }
}) ]]

return require('packer').startup{function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}
    -- neorg
    use {
        "nvim-neorg/neorg",
        branch = "main",
        config = function()
            require('neorg').setup {
                -- Tell Neorg what modules to load
                load = {
                    ["core.defaults"] = {}, -- Load all the default modules
                    ["core.norg.concealer"] = {}, -- Allows for use of icons
                    ["core.keybinds"] = { -- Configure core.keybinds
                        config = {
                            default_keybinds = true, -- Generate the default keybinds
                            neorg_leader = "<Leader>o" -- This is the default if unspecified
                        }
                    },
                    ["core.norg.dirman"] = { -- Manage your directories with Neorg
                        config = {
                            workspaces = {
                                main = "~/Seafile/Notes/personal",
                                work = "~/Seafile/Notes/work",
                                -- gtd = "~/Seafile/Neorg/gtd"
                            }
                        }
                    },
                    ["core.integrations.telescope"] = {}, -- Enable the telescope module
                    -- ["core.gtd.base"] = {
                    --     config = {
                    --         workspace = "gtd" -- assign the workspace,
                    --     },
                    -- }, -- Enable GTD module
                    ["core.norg.completion"] = {
                        config = {
                            engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
                        },
                    },
                },
            }
        end,
        requires = {"nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope"}
    }

    -- Syle plugins
    use { "sainnhe/gruvbox-material"}
    use { "kyazdani42/nvim-web-devicons" }
    use { "romgrk/barbar.nvim", requires = {"kyazdani42/nvim-web-devicons"}}
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
          require('lualine').setup{
            options = {
              theme = 'gruvbox',
              section_separators = {left = '', right=''},
              component_separators = {left = '', right=''},
              icons_enabled = true,
            },
            sections = {
              lualine_a = { {'mode', upper = true} },
              lualine_b = { {'branch', icon = ''} },
              lualine_c = { {'filename', file_status = true} },
              lualine_x = { 'encoding', 'fileformat', 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location'  },
            },
            inactive_sections = {
              lualine_a = {  },
              lualine_b = {  },
              lualine_c = { 'filename' },
              lualine_x = { 'location' },
              lualine_y = {  },
              lualine_z = {   }
            },
          }
        end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    use {
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use { 'yamatsum/nvim-cursorline',
        config = function()
            vim.g.cursorword_highlight = 1
        end
    }

    use {
        "jqfeld/FTerm.nvim",
        config = function()
            require("FTerm").setup({
                dimensions = {
                    height = 0.8,
                    width = 0.8,
                    x = 0.5,
                    y = 0.5
                },
                border = 'single'
            })
        end
    }

    if vim.api.nvim_call_function('has',{"unix"}) then
        use {
            "jqfeld/FTerm-nnn.nvim",
            requires = { "jqfeld/FTerm.nvim" },
        }
    end
    --
    -- Language support plugins
    use { 'p00f/nvim-ts-rainbow' }

    use { 'windwp/nvim-autopairs' }

    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

            parser_configs.norg = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg",
                    files = { "src/parser.c", "src/scanner.cc" },
                    branch = "main"
                },
            }
            parser_configs.norg_meta = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
                    files = { "src/parser.c" },
                    branch = "main"
                },
            }

            parser_configs.norg_table = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
                    files = { "src/parser.c" },
                    branch = "main"
                },
            }

            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"julia", "rust", "lua", "c", "make", "norg", "norg_meta", "norg_table", "latex"},
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
    use { 'nvim-treesitter/playground'}

    use({
      "neovim/nvim-lspconfig",
    })

    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
    use { 'rafamadriz/friendly-snippets' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/nvim-cmp',
        config = function ()
            require('config.cmp')
        end
    }
    use { 'L3MON4D3/LuaSnip',
        config = function ()
            require('config.snippets')
        end
    }

    -- use { 'ray-x/lsp_signature.nvim' }
    -- use { 'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- Rust
    use {'mfussenegger/nvim-dap'}

    -- Julia
    use { 'JuliaEditorSupport/julia-vim' }
    use { 'hkupty/iron.nvim' }


    -- Tables
    use { 'dhruvasagar/vim-table-mode' }

    -- Git
    use { 'TimUntersberger/neogit',
        config = function()
            require'neogit'.setup {}
        end
    }

    -- use {
    --   "blackCauldron7/surround.nvim",
    --   config = function()
    --     require"surround".setup {mappings_style = "surround"}
    --   end
    -- }
    
    -- LaTeX
    use { 'lervag/vimtex' }




    -- Dev projects
    use { 'jqfeld/watson.nvim',
        requires = {{'nvim-lua/plenary.nvim'}, {'nvim-lua/popup.nvim'},
                    {'nvim-telescope/telescope.nvim'}},
    }
    if packer_bootstrap then
        require('packer').sync()
    end

end}

