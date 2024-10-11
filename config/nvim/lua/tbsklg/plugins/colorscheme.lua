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
        end
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            require('kanagawa').setup({
                transparent = true,
                theme = "wave",
            })
        end
    }
}
