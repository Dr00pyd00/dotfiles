require("core.options")
require("core.lazy")
require("core.keymaps")

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})

