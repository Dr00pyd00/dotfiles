return {
    "numToStr/Comment.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    
config = function()
    require("Comment").setup({
        pre_hook = function(ctx)
            local U = require("Comment.utils")

            if vim.bo.filetype == "python" then
                return "# %s"
            end
        end,
    })
end
}
