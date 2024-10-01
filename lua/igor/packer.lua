-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'


    -- Telescope 
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Colorscheme
    use { 
        "rose-pine/neovim", 
        as = "rose-pine",
        config = function() 
            vim.cmd("colorscheme rose-pine")
        end
    }

    -- TreeSitter
    use {'nvim-treesitter/nvim-treesitter',{run = ':TSUpdate'}}

    -- TreeSitter Playground
    use {'nvim-treesitter/playground'}

    -- Harpoon
    use {'nvim-lua/plenary.nvim'}
    use {'ThePrimeagen/harpoon'}

    -- Undotree
    use  {'mbbill/undotree'}

    -- Vim Fugitive
    use {'tpope/vim-fugitive'}

    -- LSP Zero
    use {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'}
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/nvim-cmp'}
    use {'williamboman/mason.nvim'}
    use {'williamboman/mason-lspconfig.nvim'}

    -- Git Signs
    use {'lewis6991/gitsigns.nvim'}
end)
