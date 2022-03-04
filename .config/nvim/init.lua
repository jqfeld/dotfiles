P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, 'plenary') then
    RELOAD = require('plenary.reload').reload_module
    R = function(name)
        RELOAD(name)
        return require(name)
    end
else
    R = function(name)
        return require(name)
    end
end

R('plugins')

local opt = vim.opt
local G = vim.g
local cmd = vim.api.nvim_command

G.nvim_config_root = vim.fn.stdpath('config')
G.mapleader = " "
G.vimtex_view_method = 'zathura'

opt.mouse = "a"

opt.swapfile = false
opt.autoread = true
opt.number = true
opt.encoding = "utf-8"
opt.visualbell = true

-- indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
-- opt.smartindent = true

cmd("filetype plugin indent on")

opt.ttyfast = true
opt.lazyredraw = true

-- search and replace
opt.showmatch = true
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.wrap = false

opt.autochdir = true
opt.hidden = true
opt.inccommand="split"
opt.splitbelow=true
opt.splitright=true

opt.completeopt="menu,menuone,noselect,noinsert"

opt.cursorline = true
opt.showmode = true
opt.showcmd = true

-- colors
opt.termguicolors = true
opt.background = "dark"
G.gruvbox_material_enable_italic = 1
cmd("colorscheme gruvbox-material")


opt.clipboard = "unnamedplus"

cmd("au FocusGained,BufEnter * :silent! !")
-- cmd([[augroup HTMLTemplates
--     autocmd!
--     autocmd BufReadPre,FileReadPre *.hbs set ft=html
--     autocmd BufReadPre,FileReadPre *.tera set ft=html
-- augroup END
-- ]])

R('lsp_config')
R('plugin_settings')
R("keymaps")
-- R('mathedit')
