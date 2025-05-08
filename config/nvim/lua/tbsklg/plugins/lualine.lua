return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        lualine.setup({
            options = {
                disabled_filetypes = { "NvimTree" },
            },
            sections = {
                lualine_a = {
                    { "mode" },
                },
                lualine_b = {
                    "diff",
                },
                lualine_c = {
                    "diagnostics",
                },
                lualine_x = {
                    { "filename" },
                    { "filetype" },
                    { "encoding" },
                },
            },
        })
    end,
}
