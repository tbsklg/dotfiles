return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
            --vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "RRethy/base16-nvim",
        config = function()
            require('base16-colorscheme').with_config({
                telescope = false
            })
            vim.cmd("colorscheme base16-gruvbox-dark-hard")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                keywordStyle = { italic = false },
                transparent = true,
                background = {
                    dark = "wave",
                },
            });
            --vim.cmd("colorscheme kanagawa")
        end
    }
}
