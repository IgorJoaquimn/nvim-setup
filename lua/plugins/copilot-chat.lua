return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Toggle" },
            { "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "Copilot Chat Fix" },
            { "<leader>ccg", "<cmd>CopilotChatCommit<cr>", desc = "Copilot Chat Commit" },

        },
        opts = {
            -- default mappings
            -- see config/mappings.lua for implementation
            mappings = {
                complete = {
                    insert = '<Tab>',
                },
                close = {
                    normal = 'q',
                    insert = '<C-c>',
                },
                reset = {
                    normal = '<C-l>',
                    insert = '<C-l>',
                },
                submit_prompt = {
                    normal = '<CR>',
                    insert = '<C-s>',
                },
                toggle_sticky = {
                    normal = 'grr',
                },
                clear_stickies = {
                    normal = 'grx',
                },
                accept_diff = {
                    normal = '<leader>ad',
                    insert = '<leader>ad',
                },
                jump_to_diff = {
                    normal = 'gj',
                },
                quickfix_answers = {
                    normal = 'gqa',
                },
                quickfix_diffs = {
                    normal = 'gqd',
                },
                yank_diff = {
                    normal = 'gy',
                    register = '"', -- Default register to use for yanking
                },
                show_diff = {
                    normal = 'gd',
                    full_diff = false, -- Show full diff instead of unified diff when showing diff window
                },
                show_info = {
                    normal = 'gi',
                },
                show_context = {
                    normal = 'gc',
                },
                show_help = {
                    normal = 'gh',
                },
            },
            -- See Commands section for default commands if you want to lazy load on them
        },
    }
}
