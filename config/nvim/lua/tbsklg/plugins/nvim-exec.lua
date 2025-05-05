return {
    "tbsklg/nvim-exec",
    branch = "main",
    ft = { "javascript", "typescript" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local nvim_exec = require("nvim-exec").setup({
            output_mode = "comment",
        })

        vim.keymap.set({ "n", "v" }, "<leader>rc", function()
            nvim_exec.run()
        end, { desc = "Execute code block in comment" })
    end,
}
