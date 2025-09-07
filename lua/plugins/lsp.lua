-- Alternative LSP setup with blink.cmp (more modern and stable)
return {
    "neovim/nvim-lspconfig",
    dependencies = {
<<<<<<< HEAD
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        {
            "saghen/blink.cmp",
            dependencies = "rafamadriz/friendly-snippets",
            version = "v0.*",
            opts = {
                keymap = {
                    preset = 'none',
                    -- Accept the selected suggestion
                    ['<C-Space>'] = { 'select_and_accept' },
                    
                    -- Navigation with arrow keys
                    ['<Up>'] = { 'select_prev', 'fallback' },
                    ['<Down>'] = { 'select_next', 'fallback' },
                    
                    -- Alternative navigation (keeping your C-p/C-n as backup)
                    ['<C-p>'] = { 'select_prev', 'fallback' },
                    ['<C-n>'] = { 'select_next', 'fallback' },
                    
                    -- Other useful keys
                    ['<C-e>'] = { 'hide' },                        -- Hide completion
                    ['<Esc>'] = { 'hide', 'fallback' },            -- Escape to hide
                    
                    -- Documentation scrolling
                    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = 'mono'
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
                completion = {
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    }
                }
            }
        }
    },

    config = function()
        local lspconfig = require("lspconfig")
        
        -- LSP capabilities with blink.cmp
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        
=======
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

>>>>>>> ea0b9576e5ea380bf52eca27e5420300715959e3
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

<<<<<<< HEAD
        -- Diagnostics configuration
=======
        -- Simple diagnostics
>>>>>>> ea0b9576e5ea380bf52eca27e5420300715959e3
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            update_in_insert = false,
        })

<<<<<<< HEAD
        -- Keymaps for LSP
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
        end

        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "gj", function() vim.diagnostic.goto_next({ float = { source = true } }) end, "Next diagnostic")
        map("n", "gk", function() vim.diagnostic.goto_prev({ float = { source = true } }) end, "Prev diagnostic")
=======
        -- Basic LSP keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
        vim.keymap.set("n", "gj", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
        vim.keymap.set("n", "gk", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
>>>>>>> ea0b9576e5ea380bf52eca27e5420300715959e3
    end
}
