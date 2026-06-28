return {
    "numToStr/Comment.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("Comment").setup()

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "python", "lua", "c" },
            callback = function()
                local cs = vim.bo.commentstring
                if cs == "" or cs == nil then
                    vim.bo.commentstring = "# %s"
                end
            end
        })
    end
}
