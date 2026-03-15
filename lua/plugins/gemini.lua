return {
    "marcinjahn/gemini-cli.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        -- You can add your configuration here
        -- See the plugin's documentation for available options
    },
    keys = {
        { "<leader>gc", "<cmd>GeminiChat<cr>", desc = "Gemini Chat" },
    },
}
