return {
    "nvim-java/nvim-java",
    ft = "java",
    config = function()
        -- nvim-java manages the jdtls install/lifecycle itself; it must be
        -- set up before jdtls is enabled. mason-lspconfig is told to skip
        -- jdtls (see lsp/mason.lua) so the server isn't enabled twice.
        require("java").setup()
        vim.lsp.enable("jdtls")
    end,
}
