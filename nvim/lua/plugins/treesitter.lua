return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- installe les parsers voulus (API de la branche main)
    require("nvim-treesitter").install({
      "c", "python", "lua", "bash", "vim", "vimdoc", "markdown",
    })

    -- démarre treesitter (highlight + folding) sur ces filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "python", "lua", "bash", "sh", "vim", "markdown" },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
