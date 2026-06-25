return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = {
                "angularls",
                "ts_ls",
                "html",
                "cssls",
                "lua_ls",
                "pyright",
                "zls",
                "gopls",
            },
            automatic_enable = {
                exclude = {
                    "rust_analyzer",
                    "ts_ls",
                    "angularls",
                    -- jdtls is managed by nvim-java (see plugins/java.lua)
                    "jdtls",
                },
            },
        })

        local mason_tool_installer = require("mason-tool-installer")
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "eslint",
                "eslint_d",
                "goimports",
                "golangci-lint",
            },
        })
    end,
}
