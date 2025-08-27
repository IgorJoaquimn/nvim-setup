return 
{
    'lewis6991/gitsigns.nvim',
    keys = {
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Gitsigns Preview Hunk" },
    },
    config = function()
        require('gitsigns').setup()
    end,
}
