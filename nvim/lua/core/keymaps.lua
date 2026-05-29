-- Diagnostics
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Erreur Python" })

-- Terminal
vim.keymap.set("n", "<leader>t", function()
  vim.cmd("botright split")
  vim.cmd("terminal")
end, { desc = "Terminal" })

vim.keymap.set("n", "<leader>C", function()
  local cmp = require("cmp")
  if cmp.get_config().completion.autocomplete then
    cmp.setup({ completion = { autocomplete = false } })
    print("Complétion OFF")
  else
    cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
    print("Complétion ON")
  end
end, { desc = "Toggle complétion" })

 
