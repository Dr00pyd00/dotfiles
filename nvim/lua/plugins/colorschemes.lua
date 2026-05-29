return {
  { "Mofiqul/dracula.nvim" },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- choix : latte | frappe | macchiato | mocha
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          cmp = true,
          mason = true,
        },
      })
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
  { "ellisonleao/gruvbox.nvim" },
  { "bluz71/vim-moonfly-colors", name = "moonfly" },
  { "EdenEast/nightfox.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "sainnhe/everforest" },
  { "sainnhe/sonokai" },
  { "navarasu/onedark.nvim" },
  { "scottmckendry/cyberdream.nvim" },
}

