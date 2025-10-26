return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                compile = true,
                keywordStyle = { italic = true },
                transparent = false,
            })
            --vim.cmd("colorscheme kanagawa")
        end,
        build = function()
            --vim.cmd("KanagawaCompile")
        end,
    },
    {
        "webhooked/kanso.nvim",
        config = function()
            vim.cmd("colorscheme kanso")
        end,
        build = function()
        end,
    },
}
