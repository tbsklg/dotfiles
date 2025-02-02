return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
            --vim.cmd("colorscheme rose-pine")
        end,
    },
    {
        "wincent/base16-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox-dark-hard]])
            vim.o.background = "dark"
            local bools = vim.api.nvim_get_hl(0, { name = "Boolean" })
            vim.api.nvim_set_hl(0, "Comment", bools)
            local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
            vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
                fg = marked.fg,
                bg = marked.bg,
                ctermfg = marked.ctermfg,
                ctermbg = marked.ctermbg,
                bold = true,
            })
        end,
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
            })
            --vim.cmd("colorscheme kanagawa")
        end,
    },
}
