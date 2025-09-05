return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "hrsh7th/cmp-nvim-lsp", -- keep this so LSP capabilities work with cmp
    },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp_lsp = require("cmp_nvim_lsp")

        -- Capabilities for LSP servers with nvim-cmp integration
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- Fidget for LSP progress
        require("fidget").setup({})

        -- Mason setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "csharp_ls",
                "gopls",
                "templ",
                "powershell_es",
                "tflint",
                "terraformls",
            },
            handlers = {
                -- Default handler for all servers
                function(server_name)
                    lspconfig[server_name].setup {
                        capabilities = capabilities,
                    }
                end,
                -- Lua LSP special settings
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    }
                end,
            },
        })

        -- Custom filetype for .templ files
        vim.filetype.add({ extension = { templ = "templ" } })

        -- Configure diagnostics
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

