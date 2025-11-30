return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                compile = true,
                keywordStyle = { italic = true },
                transparent = false,
            })
            -- vim.cmd("colorscheme kanagawa")
        end,
        build = function()
            vim.cmd("KanagawaCompile")
        end,
    },
    {
        "vague-theme/vague.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("vague").setup({})
            vim.cmd("colorscheme vague")
        end,
    },
}
