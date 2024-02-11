return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      dim_inactive = {
        enabled = true,   -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
    },
    integrations = {
      headlines = true,
      neogit = true,
      symbols_outline = true,
      which_key = true,
    }
  },
  -- color html colors
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup {
        css = { css_fn = true, css = true },
        'javascript',
        'html',
        'r',
        'rmd',
        'qmd',
        'markdown',
        'python'
      }
    end
  },
}
