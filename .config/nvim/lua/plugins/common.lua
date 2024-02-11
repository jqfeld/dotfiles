return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  {
    "jqfeld/kiwi.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- dir = "~/Projects/Current/kiwi.nvim",
    -- dev = true,
    opts = {
      {
        name = "work",
        path = vim.fn.expand("~/Work/notes")
      },
      {
        name = "personal",
        path = vim.fn.expand("~/Notes")
      },
    },
    keys = {
      { "<leader>nn", ":lua require(\"kiwi\").open_wiki_index('personal')<cr>", desc = "Open Wiki index" },
      { "<leader>nw", ":lua require(\"kiwi\").open_wiki_index('work')<cr>",     desc = "Open Wiki index" },
      { "<C-X>",      ":lua require(\"kiwi\").todo.toggle()<cr>",               desc = "Toggle Markdown Task" }
    },
    -- lazy = true
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
