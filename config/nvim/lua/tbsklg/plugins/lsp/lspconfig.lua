return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
            callback = function(event)
                local bufnr = event.buf
                local map = function(mode, lhs, rhs, desc)
                    keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
                end

                map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show references")
                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, "Show definitions")
                map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
                map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
                map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
                map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
                map("n", "<leader>ld", vim.diagnostic.open_float, "Show line diagnostics")
                map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
                map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
                map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
                map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
            end,
        })

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                    [vim.diagnostic.severity.HINT] = "󰠠 ",
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                },
            },
            virtual_text = true,
            float = { border = "rounded" },
        })

        vim.lsp.config("*", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            },
        })

        vim.lsp.config("ts_ls", {
            init_options = {
                preferences = {
                    disableSuggestions = true,
                },
            },
        })
        vim.lsp.enable("ts_ls")

        vim.lsp.config("zls", {
            settings = {
                zls = {
                    enable_build_on_save = true,
                },
            },
        })
        vim.lsp.enable("zls")
    end,
}
