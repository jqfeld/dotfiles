return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
      require('nvim-autopairs').remove_rule('`')
    end
  },
  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  {
    'numToStr/Comment.nvim',
    version = nil,
    branch = 'master',
    config = true, -- default settings
  },
  {
    "chrishrb/gx.nvim",
    event = { "BufEnter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
  },

  {
    "dhruvasagar/vim-table-mode",
  },
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup({
        auto_load = true,        -- whether to automatically load preview when
        -- entering another markdown buffer
        close_on_bdelete = true, -- close preview window on buffer delete

        syntax = true,           -- enable syntax highlighting, affects performance

        theme = 'light',         -- 'dark' or 'light'

        update_on_change = true,

        app = 'webview', -- 'webview', 'browser', string or a table of strings
        -- explained below

        filetype = { 'markdown' }, -- list of filetypes to recognize as markdown

        -- relevant if update_on_change is true
        throttle_at = 200000,   -- start throttling when file exceeds this
        -- amount of bytes in size
        throttle_time = 'auto', -- minimum amount of time in milliseconds
        -- that has to pass before starting new render
      })
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
    ft = "markdown",
    keys = {
      { "<LocalLeader>o", "<cmd>PeekOpen<cr>",  desc = "Open preview" },
      { "<LocalLeader>c", "<cmd>PeekClose<cr>", desc = "Close preview" },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "davidgranstrom/nvim-markdown-preview"
  },
  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  {
    'jqfeld/clipboard-image.nvim',
    opts = {
      default = {
        img_dir = "assets",
        img_dir_txt = "assets",
        -- img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
        -- affix = "<\n  %s\n>"                                       -- Multi lines affix
      },
      -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
      -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
      -- Missing options from `markdown` field will be replaced by options from `default` field
      -- markdown = {
      --   img_dir = { "src", "assets", "img" }, -- Use table for nested dir (New feature form PR #20)
        -- img_dir_txt = "/assets/img",
      --   img_handler = function(img)     -- New feature from PR #22
      --     local script = string.format('./image_compressor.sh "%s"', img.path)
      --     os.execute(script)
      --   end,
      -- }
    }
  },
}
