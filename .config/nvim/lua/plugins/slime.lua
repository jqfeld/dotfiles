return {
  {
    'jpalardy/vim-slime',
    init = function()
      vim.g.slime_target = "zellij"
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_python_ipython = 1
      vim.g.slime_default_config = { session_id = "current", relative_pane = "right" }
    end,
    config = function()
      vim.g.slime_cell_delimiter = "^##"
      require("which-key").add({
        { "<Leader>c",  group = "Code runner" },
        { "<Leader>cv", "<Plug>SlimeConfig",   desc = "slime config" },
        { "<Leader>cx", "<Plug>SlimeSendCell", desc = "run cell" },
        { "<Leader>cc", "<Plug>SlimeRegionSend", desc = "run code region", mode = "v" },
      })
    end
  },
  {
    'Klafyvel/vim-slime-cells',
    ft = { 'julia' },
    config = function()
      require("which-key").add({
        { "S-Cr", "<Plug>SlimeCellsSendAndGoToNext",   desc = "run cell and jump to next" },
        { "<Leader>cc", "<Plug>SlimeCellsSendAndGoToNext", desc = "run cell and jump to next"},
        { "<Leader>cn", "<Plug>SlimeCellsNext", desc = "next cell"},
        { "<Leader>cp", "<Plug>SlimeCellsPrev", desc = "previous cell"},
      })
    end
  }
}
