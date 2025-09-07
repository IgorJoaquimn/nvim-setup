-- Alternative LSP setup with blink.cmp (more modern and stable)
return {
    "neovim/nvim-lspconfig",
    dependencies = {
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
        
        -- Plugin setups
        require("fidget").setup({})
        require("mason").setup()

        -- Helper: Setup LSP server with capabilities
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
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,

                -- Lua LSP
                ["lua_ls"] = function()
                    setup_server("lua_ls", {
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    })
                end,
            }
        })

        -- Diagnostics configuration
        vim.diagnostic.config({
            virtual_text = { format = function() return "" end },
            signs = false,
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- Keymaps for LSP
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
        end

        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "gj", function() vim.diagnostic.goto_next({ float = { source = true } }) end, "Next diagnostic")
        map("n", "gk", function() vim.diagnostic.goto_prev({ float = { source = true } }) end, "Prev diagnostic")
    end
}
