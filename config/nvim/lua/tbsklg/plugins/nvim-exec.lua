return {
    "tbsklg/nvim-exec",
    branch = "main",
    ft = { "javascript", "typescript" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local nvim_exec = require("nvim-exec").setup({})

        vim.keymap.set({ "n", "v" }, "<leader>r", function()
            nvim_exec.run()
        end, { desc = "Execute code block in comment" })
    end,
}
