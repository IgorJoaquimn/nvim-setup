return {
    "neovim/nvim-lspconfig",
    dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "j-hui/fidget.nvim",
    },

    config = function()
        -- Import modules
        local cmp_lsp = require("cmp_nvim_lsp")
        local lspconfig = require("lspconfig")

        -- Simple, default LSP capabilities
        local capabilities = cmp_lsp.default_capabilities()

        -- Plugin setups
        require("fidget").setup({})
        require("mason").setup()

        -- Simple LSP server setup
        local function setup_server(server, opts)
            opts = opts or {}
            opts.capabilities = capabilities
            lspconfig[server].setup(opts)
        end

        -- LSP servers to install and configure
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "gopls" },
            handlers = {
                -- Default handler
                function(server_name)
                    setup_server(server_name)
                end,

                -- Zig LSP
                zls = function()
                    setup_server("zls", {
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                    })
                end,

                -- Lua LSP
                ["lua_ls"] = function()
                    setup_server("lua_ls", {
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim" },
                                }
                            }
                        }
                    })
                end,
            }
        })

        -- Simple diagnostics
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            update_in_insert = false,
        })

        -- Basic LSP keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
        vim.keymap.set("n", "gj", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
        vim.keymap.set("n", "gk", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
    end
}
