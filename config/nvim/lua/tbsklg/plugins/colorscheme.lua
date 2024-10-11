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
        "sho-87/kanagawa-paper.nvim",
        config = function()
            require('kanagawa-paper').setup({
                undercurl = true,
                transparent = false,
                gutter = false,
                dimInactive = false,
                terminalColors = true,
                commentStyle = { italic = true },
                functionStyle = { italic = false },
                keywordStyle = { italic = false, bold = false },
                statementStyle = { italic = false, bold = false },
                typeStyle = { italic = false },
                colors = { theme = {}, palette = {} }, -- override default palette and theme colors
                overrides = function()   -- override highlight groups
                    return {}
                end,
            })
        end
    }
}
