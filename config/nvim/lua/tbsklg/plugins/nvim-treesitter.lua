local parsers = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "prisma",
    "markdown",
    "markdown_inline",
    "graphql",
    "gleam",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "query",
    "rust",
    "toml",
    "zig",
    "go",
    "gomod",
    "gosum",
    "gowork",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require("nvim-treesitter").setup()
            require("nvim-treesitter").install(parsers):wait(300000)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    vim.bo.indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
