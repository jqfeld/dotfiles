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
G.maplocalleader = ","

opt.mouse = "a"

opt.swapfile = false
opt.autoread = true
opt.number = true
opt.encoding = "utf-8"
opt.visualbell = true
opt.textwidth = 79


-- opt.foldlevel = 20
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldmethod = "expr"
opt.foldenable = false


-- indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
-- opt.smartindent = true

-- conceal
opt.conceallevel=1

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


opt.cursorline = true
opt.showmode = true
opt.showcmd = true

-- colors
opt.termguicolors = true
opt.background = "dark"
G.gruvbox_material_enable_italic = 1
cmd("colorscheme gruvbox-material")


opt.clipboard = "unnamedplus"

-- cmd("au FocusGained,BufEnter * :silent! !")
-- cmd([[augroup HTMLTemplates
--     autocmd!
--     autocmd BufReadPre,FileReadPre *.hbs set ft=html
--     autocmd BufReadPre,FileReadPre *.tera set ft=html
-- augroup END
-- ]])
--
vim.filetype.add({
  filename = {
    ["todo.txt"] = "todotxt",
    ["done.txt"] = "todotxt",
  },
})
R('config.lsp')
R("config.keymaps")
R('config.telescope')
R('config.cmp')
R('config.snippets')
R('scratch')

-- R('mathedit')

vim.cmd [[autocmd ColorScheme * highlight! link NormalFloat Normal]]
vim.cmd [[autocmd ColorScheme * highlight! link FloatBorder Normal]]

opt.guifont= "Fira Code Retina:h12"




