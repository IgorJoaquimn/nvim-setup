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

    -- LSP Zero
    {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

}
