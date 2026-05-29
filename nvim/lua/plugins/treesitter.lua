return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "lua", "bash", "sh" },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}

