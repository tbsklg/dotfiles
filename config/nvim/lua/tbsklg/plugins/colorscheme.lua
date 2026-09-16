return {
    {
        "wincent/base16-nvim",
        name = "base16-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox-dark-hard")

            vim.api.nvim_set_hl(0, "Normal", { fg = 0xebdbb2, bg = 0x1d2021 })
            vim.api.nvim_set_hl(0, "Cursor", { fg = 0x1d2021, bg = 0xebdbb2 })

            local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
            local dim = vim.api.nvim_get_hl(0, { name = "@variable.member" }).fg

            for _, group in ipairs({ "Comment", "@comment" }) do
                vim.api.nvim_set_hl(0, group, { fg = 0x928374, italic = true })
            end

            vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })

            for _, group in ipairs({
                "Identifier",
                "@variable",
                "@variable.parameter",
                "@lsp.type.variable",
                "@lsp.type.parameter",
            }) do
                vim.api.nvim_set_hl(0, group, { fg = fg })
            end

            for _, group in ipairs({
                "@punctuation.delimiter",
                "@punctuation.bracket",
            }) do
                vim.api.nvim_set_hl(0, group, { fg = dim })
            end

            vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = 0x282828 })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = 0x665c54, bg = 0x282828 })

            for _, group in ipairs({
                "LspReferenceText",
                "LspReferenceRead",
                "LspReferenceWrite",
            }) do
                vim.api.nvim_set_hl(0, group, { bg = 0x3c3836 })
            end

            vim.api.nvim_set_hl(0, "DiffAdd", { bg = 0x393c22 })
            vim.api.nvim_set_hl(0, "DiffDelete", { fg = 0x3c3836, bg = "NONE" })
            vim.api.nvim_set_hl(0, "DiffChange", { bg = 0x2b2c2b })
            vim.api.nvim_set_hl(0, "DiffText", { bg = 0x47443f })

            vim.api.nvim_create_autocmd("User", {
                pattern = "DiffviewViewOpened",
                callback = function()
                    vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = 0x452724 })
                    vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { fg = 0x3c3836, bg = "NONE" })
                end,
            })

            vim.api.nvim_set_hl(0, "Added", { fg = 0xb8bb26 })
            vim.api.nvim_set_hl(0, "Removed", { fg = 0xfb4934 })
            vim.api.nvim_set_hl(0, "Changed", { fg = 0x83a598 })
            vim.api.nvim_set_hl(0, "diffAdded", { fg = 0xb8bb26 })
            vim.api.nvim_set_hl(0, "diffRemoved", { fg = 0xfb4934 })
            vim.api.nvim_set_hl(0, "diffChanged", { fg = 0x83a598 })
        end,
    },
}
