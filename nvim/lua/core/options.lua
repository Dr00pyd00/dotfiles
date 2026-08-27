


-- Options de base
vim.opt.number = true          -- numéros de lignes
vim.opt.relativenumber = true  -- numéros relatifs
vim.opt.tabstop = 4            -- largeur d'une tabulation
vim.opt.shiftwidth = 4         -- largeur de l'indentation
vim.opt.expandtab = true       -- convertit les tabs en espaces
vim.opt.smartindent = true     -- indentation intelligente
vim.opt.wrap = false           -- pas de retour à la ligne automatique
vim.opt.mouse = "a"            -- souris activée partout
vim.opt.clipboard = "unnamedplus" -- partage le presse-papier avec le système
vim.opt.termguicolors = true   -- couleurs 24 bits
vim.opt.scrolloff = 8          -- garde 8 lignes visibles au dessus/dessous du curseur
vim.g.mapleader = " "
vim.opt.cursorline = true


-- Presse-papier : on force xclip au lieu de laisser nvim choisir tout seul.
-- Sans ca il bascule sur OSC 52, que le terminal ne sait pas gerer
-- (symptome : "+q4D73" ecrit dans le buffer au demarrage).
if vim.fn.executable("xclip") == 1 then
  vim.g.clipboard = {
    name = "xclip",
    copy = {
      ["+"] = "xclip -selection clipboard",
      ["*"] = "xclip -selection primary",
    },
    paste = {
      ["+"] = "xclip -selection clipboard -o",
      ["*"] = "xclip -selection primary -o",
    },
    cache_enabled = 1,
  }
end


-- ajout path pour voir les includes C:
vim.opt.path:append("/usr/include")
vim.opt.path:append("/usr/include/sys/")
vim.opt.path:append("/usr/include/x86_64-linux-gnu")



-- Désactiver la continuation automatique des commentaires
vim.opt.formatoptions:remove({ "c", "r", "o" })


