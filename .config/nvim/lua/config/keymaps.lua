local wk = require("which-key")

-- with leader
wk.register({
  f = {
    name = "Find", -- optional group name
    f = { function() require("telescope.builtin").find_files() end, "Find file" },
    h = { function() require("telescope.builtin").help_tags() end, "Find help" },
    b = { function() require("telescope.builtin").buffers() end, "Find buffer" },
    B = { require("telescope.builtin").current_buffer_fuzzy_find, "Find in current buffer" },
    e = { function() require("telescope").extensions.file_browser.file_browser() end, "File Browser" },
    v = { function() require("telescope.builtin").oldfiles() end, "Find in history" },
    t = { require("telescope.builtin").treesitter, "Find treesitter" },
    T = { "<CMD>TodoTelescope<CR>", "Find todo comments" },
    -- My custom ones
    -- r = { require("citation").telescope_cite, "Find references" },
    p = { function() require("telescope.builtin").find_files({ cwd = "~/projects" }) end, "Find in projects" },
    j = { function() require("telescope.builtin").find_files({ cwd = "~/.julia/dev/" }) end, "Find in julia dev" },
    P = { function() require("telescope.builtin").find_files({ cwd = "~/.local/share/nvim/site/pack/packer/start" }) end,
      "Find in plugins" },
    c = {
      name = "Neovim config",
      f = { function() require("telescope.builtin").find_files({ cwd = "~/.config/nvim" }) end, "Find in config" },
      d = { "<CMD>e $MYVIMRC<CR>", "Open config" },
      r = { "<CMD>source $MYVIMRC<CR>", "Reload config" },
    },
  },

  g = {
    name = "Neogit",
    g = { function() require("neogit").open('tab') end, "Open Git status" },
  },

  w = {
    name = "Watson",
    d = { function()
      R('watson');
      require('watson').find_data()
    end, "Insert data" },
    D = { function()
      R('watson');
      require('watson').find_data({ insert = false })
    end, "Open data" },
    s = { function()
      R('watson');
      require('watson').find_in('scriptsdir', { insert = false })
    end, "Open script" },
    S = { function()
      R('watson');
      require('watson').find_in('scriptsdir', { insert = true })
    end, "Insert script" },
    p = { function()
      R('watson');
      require('watson').find_plot()
    end, "Open plot" },
    n = { function()
      R('watson');
      require('watson').find_plot()
    end, "Open note" },
  },
  n = {
    name = "Neorg",
    w = { "<CMD>Neorg workspace work<CR>", "Open Neorg for work" },
    p = { "<CMD>Neorg workspace personal<CR>", "Open Neorg for personal life" },
  },
  m = {
    name = "Markdown",
    t = { "<CMD>TableModeToggle<CR>", "Toggle table mode" },
    p = { "<CMD>MarkdownPreview<CR>", "Markdown preview" },
  },
  h = { "<CMD>noh<CR>", "No highlights" },
}, { prefix = "<leader>" })


-- without leader

-- terminal
wk.register({
  name = "Terminal",
  ["<Esc>"] = { function() vim.cmd("stopinsert") end, "Leave input mode" },
}, { mode = "t" })

-- windows
-- wk.register({
--   name = "Windows",
--   ["<C-j>"] = { "<C-W>j", "Down (Window)" },
--   ["<C-k>"] = { "<C-W>k", "Up (Window)" },
--   ["<C-l>"] = { "<C-W>l", "Right (Window)" },
--   ["<C-h>"] = { "<C-W>h", "Left (Window)" },
--   ["<C-A-J>"] = { "<C-W>J", "Move window down" },
--   ["<C-A-K>"] = { "<C-W>K", "Move window up" },
--   ["<C-A-L>"] = { "<C-W>L", "Move window right" },
--   ["<C-A-H>"] = { "<C-W>H", "Move window left" },
-- }, {mode = "n"})

-- FTerm
wk.register({
  name = "FTerm",
  ["<A-i>"] = { require("FTerm").toggle, "Toggle FTerm" }
})
wk.register({
  name = "FTerm",
  ["<A-i>"] = { require("FTerm").toggle, "Toggle FTerm" }
}, { mode = "t" })


-- LuaSnip

local luasnip = require('luasnip')
wk.register({
  name = "LuaSnip",
  ["<A-.>"] = {
    function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, "LuaSnip: Expand or jump"
  },
  ["<A-,>"] = {
    function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, "LuaSnip: Jump back"
  },
  ["<A-;>"] = {
    function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, "LuaSnip: Next choice"
  },
}, { mode = {"i" , "s"}})

