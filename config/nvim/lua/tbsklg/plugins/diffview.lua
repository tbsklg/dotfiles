return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFileHistory",
    },
    keys = {
        {
            "<leader>gd",
            "<cmd>DiffviewOpen<cr>",
            desc = "Open diff view",
        },
        {
            "<leader>gD",
            "<cmd>DiffviewClose<cr>",
            desc = "Close diff view",
        },
        {
            "<leader>gh",
            "<cmd>DiffviewFileHistory %<cr>",
            desc = "File history (current file)",
        },
        {
            "<leader>gH",
            "<cmd>DiffviewFileHistory<cr>",
            desc = "File history (repo)",
        },
    },
    opts = {
        enhanced_diff_hl = true,
    },
}
