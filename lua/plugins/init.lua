return {
    -- Telescope 
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependancies = { {'nvim-lua/plenary.nvim'} }
    },

    -- Colorscheme
    { 
        "rose-pine/neovim", 
        as = "rose-pine",
        config = function() 
            vim.cmd("colorscheme rose-pine")
        end
    },

    -- TreeSitter
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

    -- TreeSitter Playground
    'nvim-treesitter/playground',

    -- Harpoon
    'nvim-lua/plenary.nvim',
    'ThePrimeagen/harpoon',

    -- Undotree
    'mbbill/undotree',

    -- Vim Fugitive
    'tpope/vim-fugitive',

    -- LSP Zero
    {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Git Signs
    'lewis6991/gitsigns.nvim',
}
