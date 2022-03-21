local wk = require("which-key")

-- with leader
wk.register({
    f = {
        name = "Files", -- optional group name
        f = { function() require("telescope.builtin").find_files() end, "Find file" },
        p = { function() require("telescope.builtin").find_files({cwd="~/projects"}) end, "Find in projects" },
        P = { function() require("telescope.builtin").find_files({cwd="~/.local/share/nvim/site/pack/packer/start"}) end, "Find in plugins" },
        e = { function() require("telescope").extensions.file_browser.file_browser() end, "File Browser" },
        v = { function() require("telescope.builtin").oldfiles() end, "Find in history" },
        T = { "<CMD>TodoTelescope<CR>", "Telescope Todos"},
        c = {
            name =  "Neovim config",
            d = {"<CMD>e $MYVIMRC<CR>", "Open config"},
            r = {"<CMD>source $MYVIMRC<CR>", "Reload config"},
        },
    },
    g = {
        name = "Neogit",
        g = { function () require("neogit").status.create('tab') end, "Open Git status" },

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
    o = {
        name = "Neorg",
        g = { "<cmd>Neorg workspace gtd<CR>", "Workspace gtd"},
        w = { "<cmd>Neorg workspace work<CR>", "Workspace work"},
        p = { "<cmd>Neorg workspace main<CR>", "Workspace private"},
    },
    n = {
        name = "NNN",
        n = { require("FTerm-nnn").nnn_toggle , "Open NNN" },
        v = { require("FTerm-nnn").nnn_vs_toggle, "Open NNN (vertical split)"},
        h = { require("FTerm-nnn").nnn_hs_toggle, "Open NNN (horizontal split)"},
    },
    b = {
        name = "Buffer",
        d = { "<CMD>BufferOrderByDirectory<CR>", "Order by directory"},
        l = { "<CMD>BufferOrderByLanguage<CR>", "Order by language"},
    },
    m = {
        name = "Modes",
        t = { "<CMD>TableModeToggle<CR>", "Toggle table mode"},
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
    ["<A-J>"] = {"<C-W>j", "Down (Window)"},
    ["<A-K>"] = {"<C-W>k", "Up (Window)"},
    ["<A-L>"] = {"<C-W>l", "Right (Window)"},
    ["<A-H>"] = {"<C-W>h", "Left (Window)"},
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
