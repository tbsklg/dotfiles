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
        "RRethy/base16-nvim",
        config = function()
            require('base16-colorscheme').with_config({
                telescope = false
            })
        end
    }
}
