return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap

        local opts = { noremap = true, silent = true }
        local on_attach = function(_, bufnr)
            opts.buffer = bufnr

            keymap.set(
                "n",
                "gR",
                "<cmd>Telescope lsp_references<CR>",
                { desc = "Show references" }
            )
            keymap.set(
                "n",
                "gD",
                vim.lsp.buf.declaration,
                { desc = "Go to declaration" }
            )
            keymap.set(
                "n",
                "gd",
                "<cmd>Telescope lsp_definitions<CR>",
                { desc = "Show definitions" }
            )

            opts.desc = "Show LSP implementations"
            keymap.set(
                "n",
                "gi",
                "<cmd>Telescope lsp_implementations<CR>",
                opts
            ) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            keymap.set(
                "n",
                "gt",
                "<cmd>Telescope lsp_type_definitions<CR>",
                opts
            ) -- show lsp type definitions

            opts.desc = "See available code actions"
            keymap.set(
                { "n", "v" },
                "<leader>ca",
                vim.lsp.buf.code_action,
                opts
            ) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            keymap.set(
                "n",
                "<leader>D",
                "<cmd>Telescope diagnostics bufnr=0<CR>",
                opts
            ) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                    [vim.diagnostic.severity.HINT] = "󰠠 ",
                },
                linehl = {
                    [vim.diagnostic.severity.ERROR] = "Error",
                },
            },
        })

        vim.diagnostic.config({
            virtual_text = true,
        })

        lspconfig["ts_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
                preferences = {
                    disableSuggestions = true,
                },
            },
        })

        require("neodev").setup({})

        local function setup_angular_ls()
            local function get_npm_prefix()
                local handle = io.popen("npm config get prefix")
                local result = handle:read("*a")
                handle:close()
                return vim.fn.trim(result)
            end

            local npm_prefix = get_npm_prefix()
            local project_library_path = npm_prefix
                .. "/lib/node_modules/@angular/language-server"
            local ngserver_path = npm_prefix .. "/bin/ngserver"

            lspconfig["angularls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                on_new_config = function(new_config, new_root_dir)
                    new_config.cmd = {
                        ngserver_path,
                        "--stdio",
                        "--tsProbeLocations",
                        new_root_dir .. "/node_modules",
                        "--ngProbeLocations",
                        project_library_path,
                    }
                end,
            })
        end

        setup_angular_ls()
    end,
}
