local function hello()
  return [[hello world]]
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        lualine.setup({
            options = {
                disabled_filetypes = { 'NvimTree' },
            },
            sections = {
                lualine_a = {
                    { "mode" }
                },
                lualine_b = {
                    "diff"
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    { "encoding" },
                    { "filetype" },
                },
            },
        })
    end,
}
