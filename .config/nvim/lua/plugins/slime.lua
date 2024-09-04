return {

  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    'jpalardy/vim-slime',
    init = function()
      vim.g.slime_target = "zellij"
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_python_ipython = 1
      vim.g.slime_default_config = { session_id = "current", relative_pane = "right" }

      -- local function toggle_slime_zellij_nvim()
      --   if vim.g.slime_target == 'zellij' then
      --     pcall(function()
      --       vim.b.slime_config = nil
      --       vim.g.slime_default_config = nil
      --     end
      --     )
      --     -- slime, neovvim terminal
      --     vim.g.slime_target = "neovim"
      --     vim.g.slime_bracketed_paste = 0
      --     vim.g.slime_python_ipython = 1
      --   elseif vim.g.slime_target == 'neovim' then
      --     pcall(function()
      --       vim.b.slime_config = nil
      --       vim.g.slime_default_config = nil
      --     end
      --     )
      --     -- -- slime, zellij
      --     vim.g.slime_target = 'zellij'
      --     vim.g.slime_bracketed_paste = 1
      --     vim.g.slime_default_config = { session_name = "current", target_pane = "current" }
      --   end
      -- end
    end,
    config = function()
      -- Normal mode
      vim.g.slime_cell_delimiter = "^##"
      require("which-key").register({
        c = {
          name = "Code runner",
          v = { '<Plug>SlimeConfig', 'slime config' },
          x = { '<Plug>SlimeSendCell', 'run cell' }
        }
      }, { mode = 'n', prefix = "<Leader>" })
      -- Visual mode
      require("which-key").register({
        name = "Code runner",
        c = {
          c = { '<Plug>SlimeRegionSend', 'run code region' },
        }
      }, { mode = 'v', prefix = "<Leader>" })
    end
  },
  {
    'Klafyvel/vim-slime-cells',
    ft = { 'julia' },
    config = function()
      require("which-key").register({
        ['S-Cr'] = { "<Plug>SlimeCellsSendAndGoToNext", "run cell and jump to next" },
        c = {
          c = { "<Plug>SlimeCellsSendAndGoToNext", "run cell and jump to next" },
          n = { "<Plug>SlimeCellsNext", "next cell" },
          p = { "<Plug>SlimeCellsPrev", "previous cell" }
        },
      }, { mode = 'n', prefix = "<Leader>" })
    end
  }
}
