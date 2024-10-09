return {
    -- Colorscheme
    {
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    },

    -- TreeSitter Playground
    'nvim-treesitter/playground',
    'nvim-lua/plenary.nvim',
}
