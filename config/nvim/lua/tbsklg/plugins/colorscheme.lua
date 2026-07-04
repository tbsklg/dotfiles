return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                integrations = {
                    telescope = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    cmp = true,
                    harpoon = true,
                    trouble = true,
                    mason = true,
                    dressing = true,
                    which_key = true,
                    indent_blankline = { enabled = true },
                    native_lsp = { enabled = true },
                    mini = { enabled = true },
                },
            })
            vim.cmd("colorscheme catppuccin")
        end,
    },
}
