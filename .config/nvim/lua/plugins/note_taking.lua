return {
  {
    "jqfeld/markdown.nvim",
    dev = true,
    ft = "markdown", -- or 'event = "VeryLazy"'
    opts = {
      -- configuration here or empty for defaults
      mappings = {
        link_follow = false, -- (string|boolean) follow link
      },
    },
    keys = {
      -- { "gx", "<Plug>(markdown_follow_link_default_app)", desc = "Open Markdown preview" },
    },
  },


  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },

  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = false,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
            resolve_image_path = function(document_path, image_path, fallback)
              local root_dir = require('lspconfig').util.root_pattern('.git', '.obsidian', '.moxide.toml')(document_path)

              if root_dir == nil or
                  vim.startswith(image_path, "./") or
                  vim.startswith(image_path, "../") or
                  vim.startswith(image_path, "/")
              then
                return fallback(document_path, image_path)
              else
                return root_dir .. "/" .. image_path
              end
            end
          },
          neorg = {
            enabled = false,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,                                      -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
      })
    end,
  },

  {
    "dhruvasagar/vim-table-mode",
  },

  {
    'jqfeld/clipboard-image.nvim',
    opts = {
      default = {
        img_dir = "assets",
        img_dir_txt = "./assets",
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

  {"jannis-baum/vivify.vim"},

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
    keys = {
      { "<leader>mo", ":PeekOpen<cr>",  desc = "Open Markdown preview" },
      { "<leader>mc", ":PeekClose<cr>", desc = "Close Mardown preview" },
    },

  },

  -- {
  --   'vigoux/ltex-ls.nvim',
  --   dependencies = { 'neovim/nvim-lspconfig' },
  --   config = function()
  --     require 'ltex-ls'.setup {
  --       use_spellfile = false, -- Uses the value of 'spellfile' as an external file when checking the document
  --       -- window_border = 'single', -- How the border should be rendered
  --       -- Put your lsp config here, just like with nvim-lspconfig
  --     }
  --   end,
  -- },
  --
}
