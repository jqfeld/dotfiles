return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  -- {
  --   "jqfeld/kiwi.nvim",
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   -- dir = "~/Projects/Current/kiwi.nvim",
  --   -- dev = true,
  --   opts = {
  --     {
  --       name = "work",
  --       path = vim.fn.expand("~/Work/notes")
  --     },
  --     {
  --       name = "personal",
  --       path = vim.fn.expand("~/Notes")
  --     },
  --   },
  --   keys = {
  --     { "<leader>nn", ":lua require(\"kiwi\").open_wiki_index('personal')<cr>", desc = "Open Wiki index" },
  --     { "<leader>nw", ":lua require(\"kiwi\").open_wiki_index('work')<cr>",     desc = "Open Wiki index" },
  --     { "<C-X>",      ":lua require(\"kiwi\").todo.toggle()<cr>",               desc = "Toggle Markdown Task" }
  --   },
  --   -- lazy = true
  -- },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    -- lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Notes",
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Journal",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y/%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        -- alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
      },
      attachments = {
        img_folder = "attachements"
      }
    },
    keys = {
      { "<leader>os", ":ObsidianQuickSwitch<cr>", desc = "Switch Obsidian file" },
      -- { "<C-X>",      ":lua require(\"kiwi\").todo.toggle()<cr>",               desc = "Toggle Markdown Task" }
    },
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "Shatur/neovim-session-manager",
    config = function()
      require 'session_manager'.setup({
        autoload_mode = require 'session_manager.config'.AutoloadMode.CurrentDir,
      })
    end,
  }
}
