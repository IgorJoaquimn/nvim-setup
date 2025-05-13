return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        -- Import modules
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local lspconfig = require("lspconfig")
        local lspkind = require('lspkind')

        -- LSP capabilities
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

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

        -- nvim-cmp completion setup
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Cr>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'copilot' },
            }, {
                { name = 'buffer' },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    before = function(_, vim_item)
                        return vim_item
                    end
                })
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
        -- Keymaps for LSP (using LazyVim style)
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
