local wk = require("which-key")

-- with leader
wk.register({
    f = {
        name = "Files", -- optional group name
        f = { function() require("telescope.builtin").find_files() end, "Find file" },
        h = { function() require("telescope.builtin").help_tags() end, "Find help" },
        p = { function() require("telescope.builtin").find_files({cwd="~/projects"}) end, "Find in projects" },
        j = { function() require("telescope.builtin").find_files({cwd="~/.julia/dev/"}) end, "Find in julia dev" },
        P = { function() require("telescope.builtin").find_files({cwd="~/.local/share/nvim/site/pack/packer/start"}) end, "Find in plugins" },
        b = { require("telescope.builtin").current_buffer_fuzzy_find, "Find in current buffer"},
        e = { function() require("telescope").extensions.file_browser.file_browser() end, "File Browser" },
        v = { function() require("telescope.builtin").oldfiles() end, "Find in history" },
        T = { "<CMD>TodoTelescope<CR>", "Telescope Todos"},
        t = { require("telescope.builtin").treesitter, "Find treesitter" },
        r = { require("citation").telescope_cite, "Find references" },
        c = {
            name =  "Neovim config",
            f = { function() require("telescope.builtin").find_files({cwd="~/.config/nvim"}) end, "Find in config"},
            d = {"<CMD>e $MYVIMRC<CR>", "Open config"},
            r = {"<CMD>source $MYVIMRC<CR>", "Reload config"},
        },
    },
    g = {
        name = "Neogit",
        g = { function () require("neogit").open('tab') end, "Open Git status" },

    },
    w = {
        name = "Watson",
        d = { function () R('watson'); require('watson').find_data() end, "Insert data"},
        D = { function () R('watson'); require('watson').find_data({insert=false}) end, "Open data"},
        s = { function () R('watson'); require('watson').find_in('scriptsdir',{insert=false}) end, "Open script"},
        S = { function () R('watson'); require('watson').find_in('scriptsdir',{insert=true}) end, "Insert script"},
        p = { function () R('watson'); require('watson').find_plot() end, "Open plot"},
        n = { function () R('watson'); require('watson').find_plot() end, "Open note"},
    },
    n = {
        name = "NvimTree",
        n = { "<CMD>NvimTreeToggle<CR>" , "Toggle NvimTree" },
        -- v = { require("FTerm-nnn").nnn_vs_toggle, "Open NNN (vertical split)" },
        -- h = { require("FTerm-nnn").nnn_hs_toggle, "Open NNN (horizontal split)" },
    },
    b = {
        name = "Buffer",
        d = { "<CMD>BufferOrderByDirectory<CR>", "Order by directory"},
        l = { "<CMD>BufferOrderByLanguage<CR>", "Order by language"},
    },
    m = {
        name = "Markdown",
        t = { "<CMD>TableModeToggle<CR>", "Toggle table mode"},
        p = { "<CMD>MarkdownPreview<CR>", "Markdown preview"},
    },
    h = { "<CMD>noh<CR>", "No highlights" },
}, { prefix = "<leader>" })


-- without leader

-- terminal
wk.register({
    name = "Terminal",
    ["<Esc>"] = {function() vim.cmd("stopinsert") end, "Leave input mode"},
}, { mode = "t" })

-- windows
wk.register({
    name = "Windows",
    ["<A-j>"] = {"<C-W>j", "Down (Window)"},
    ["<A-k>"] = {"<C-W>k", "Up (Window)"},
    ["<A-l>"] = {"<C-W>l", "Right (Window)"},
    ["<A-h>"] = {"<C-W>h", "Left (Window)"},
    ["<C-A-J>"] = {"<C-W>J", "Move window down"},
    ["<C-A-K>"] = {"<C-W>K", "Move window up"},
    ["<C-A-L>"] = {"<C-W>L", "Move window right"},
    ["<C-A-H>"] = {"<C-W>H", "Move window left"},
})

-- buffers
wk.register({
    name = "Buffers",
    ["<A-,>"] = {"<CMD>BufferPrevious<CR>", "Previous buffer"},
    ["<A-.>"] = {"<CMD>BufferNext<CR>", "Next buffer"},
    ["<A-<>"] = {"<CMD>BufferMovePrevious<CR>", "Move buffer left"},
    ["<A->>"] = {"<CMD>BufferMoveNext<CR>", "Move buffer right"},
    ["<A-1>"] = {"<CMD>BufferGoto 1<CR>", "Buffer 1"},
    ["<A-2>"] = {"<CMD>BufferGoto 2<CR>", "Buffer 2"},
    ["<A-3>"] = {"<CMD>BufferGoto 3<CR>", "Buffer 3"},
    ["<A-4>"] = {"<CMD>BufferGoto 4<CR>", "Buffer 4"},
    ["<A-5>"] = {"<CMD>BufferGoto 5<CR>", "Buffer 5"},
    ["<A-6>"] = {"<CMD>BufferGoto 6<CR>", "Buffer 6"},
    ["<A-7>"] = {"<CMD>BufferGoto 7<CR>", "Buffer 7"},
    ["<A-8>"] = {"<CMD>BufferGoto 8<CR>", "Buffer 8"},
    ["<A-9>"] = {"<CMD>BufferGoto 9<CR>", "Buffer 9"},
    ["<A-c>"] = {"<CMD>BufferClose<CR>", "Close Buffer"},
})

-- FTerm
wk.register({
    name = "FTerm",
    ["<A-i>"] = { require("FTerm").toggle, "Toggle FTerm"}
})
wk.register({
    name = "FTerm",
    ["<A-i>"] = { require("FTerm").toggle, "Toggle FTerm"}
}, {mode="t"})


-- LuaSnip

local luasnip = require('luasnip')
wk.register({
    name = "LuaSnip",
    ["<C-K>"] = {
            function ()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, "LuaSnip: Expand or jump"
        },
}, {mode="i"})


-- the following does not work... because of mode "s"?
-- for _,m in pairs({"i", "s"}) do
--     P(m)
--     wk.register({
--         name = "LuaSnip",
--         ["<C-K>"] = {
--             function ()
--                 if luasnip.expand_or_jumpable() then
--                     luasnip.expand_or_jump()
--                 end
--             end, "LuaSnip: Expand or jump"
--         },
--         ["<C-J>"] = {
--             function ()
--                 if luasnip.jumpable(-1) then
--                     luasnip.jump(-1)
--                 end
--             end, "LuaSnip: Jump back"
--         },
--     }, {mode=m})
-- end

-- vim.keymap.set({"i","s"},
--     function()
--         if luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--         end
--     end,
-- {silent=true})
--
