function Remaps()
    local dap = require "dap"
    -- Remaps
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>d1", dap.run_to_cursor)
    vim.keymap.set("n", "<leader>d2", dap.step_into)
    vim.keymap.set("n", "<leader>d3", dap.step_over)
    vim.keymap.set("n", "<leader>d4", dap.step_out)
    vim.keymap.set("n", "<leader>d5", dap.step_back)
    vim.keymap.set("n", "<leader>d6", dap.restart)

    -- Eval var under cursor
    vim.keymap.set("n", "<leader>?", function()
        require("dapui").eval(nil, { enter = true })
    end)

end

function EventListener()

    local dap = require "dap"
    local ui = require "dapui"
    dap.listeners.before.attach.dapui_config = function()
        ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
    end
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require "dap"

            require("dapui").setup()
            require("dap-go").setup()

            -- Adapters
            -- C, C++, Rust
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "/home/igorsc/.local/share/nvim/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }

            local codelldb = {
                type = 'codelldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
                end,
                cwd = '${workspaceFolder}',
                terminal = 'integrated'
            }

            dap.configurations.c = {codelldb}
            dap.configurations.cpp = {codelldb}
            dap.configurations.rust = {codelldb}

            Remaps()
            EventListener()
        end,
    },
}
