return {
    -- Colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        config = function()
            vim.cmd("colorscheme catppuccin")
        end
    },

    -- TreeSitter Playground
    'nvim-treesitter/playground',
    'nvim-lua/plenary.nvim',
}
