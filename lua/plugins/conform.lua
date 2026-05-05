return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff" },
            },
        })

        -- Set a keymap to format the file
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
        end, { desc = "Format file" })
    end,
}

