return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("telescope").setup({
      defaults = {
        preview = {
          treesitter = false,
        },
      },
    })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Trouver un fichier" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Chercher dans les fichiers" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Voir les buffers ouverts" })
  end,
}
