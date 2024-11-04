return {
    'stevearc/overseer.nvim',
    opts = {},
    config = function ()
        require("overseer").setup({
            templates = { "builtin", "user.cpp_build" },
        })

        vim.keymap.set("n", "<leader>rt", "<CMD>OverseerRun<CR>")
        vim.keymap.set("n", "<leader>ro", "<CMD>OverseerOpen<CR>")
    end
}
