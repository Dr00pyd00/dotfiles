



return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
      require("neo-tree").setup({
        window = { width = 28 },    -- largeur par voulue

      })

    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle explorateur" })
  end,
}


