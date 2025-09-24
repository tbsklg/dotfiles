return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                compile = true,
                keywordStyle = { italic = true },
                transparent = false,
            })
            vim.cmd("colorscheme kanagawa")
        end,
        build = function()
            vim.cmd("KanagawaCompile")
        end,
    },
}
