return {
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set(
            "n",
            "<leader>a",
            mark.add_file,
            { desc = "Add file to harpoon" }
        )
        vim.keymap.set(
            "n",
            "<C-e>",
            ui.toggle_quick_menu,
            { desc = "Toggle harpoon menu" }
        )

        vim.keymap.set("n", "<C-t>", function()
            ui.nav_file(3)
        end, { desc = "Navigate to file in harpoon" })
        vim.keymap.set("n", "<C-n>", function()
            ui.nav_file(3)
        end, { desc = "Navigate to file in harpoon" })
        vim.keymap.set("n", "<C-s>", function()
            ui.nav_file(4)
        end, { desc = "Navigate to file in harpoon" })
    end,
}
