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
 
    -- Remote-nvim
    {
        "amitds1997/remote-nvim.nvim",
        version = "*", -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim", -- For standard functions
            "MunifTanjim/nui.nvim", -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = true,
    },
}
