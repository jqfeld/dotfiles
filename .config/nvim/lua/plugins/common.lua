return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },

  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- {
  --   "Shatur/neovim-session-manager",
  --   config = function()
  --     require 'session_manager'.setup({
  --       autoload_mode = require 'session_manager.config'.AutoloadMode.CurrentDir,
  --     })
  --   end,
  -- },
}
