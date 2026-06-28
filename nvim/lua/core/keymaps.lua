--
-- vim.keymap.set("mode", "touche", action, { desc = "description" } )
-- mode => mode nvim : normal, visual etc 
-- touche => combinaison de touches 
-- action => ce que ca fait
-- desc => explication perso
--
--




-- Diagnostics
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Erreur Python" })

-- Terminal
vim.keymap.set("n", "<leader>t", function()
  vim.cmd("botright split")
  vim.cmd("terminal")
end, { desc = "Terminal" })

-- Autocompletion 
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


-- Surlignage cursor
vim.keymap.set("n", "<leader>0", function()
    vim.opt.cursorline = not vim.opt.cursorline:get()
end, { desc = "Toggle cursorline" } )
    
 
