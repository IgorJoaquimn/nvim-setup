-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>pf', function() require('telescope.builtin').find_files() end, desc = "Find Files" },
        { '<C-p>', function() require('telescope.builtin').git_files() end, desc = "Git Files" },
        { '<leader>ps', function() 
            require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
        end, desc = "Grep String" },
    },
    config = function()
        -- Any additional telescope configuration can go here
    end,
}
