return {
    "marcinjahn/gemini-cli.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    cmd = { "Gemini" },
    opts = {
        -- You can add your configuration here
        -- See the plugin's documentation for available options
    },
    keys = {
        { "<leader>gc", "<cmd>Gemini<cr>", desc = "Gemini Chat" },
    },
}
